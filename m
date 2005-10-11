Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVJKQ2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVJKQ2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 12:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVJKQ2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 12:28:11 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:3815 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S932217AbVJKQ2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 12:28:10 -0400
Message-ID: <434BE7E9.8000501@mysql.com>
Date: Tue, 11 Oct 2005 18:27:21 +0200
From: Jonas Oreland <jonas@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050911
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
CC: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       discuss@x86-64.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced
 TSCs
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20051007122624.GA23606@tentacle.sectorb.msk.ru> <200510071431.47245.ak@suse.de> <20051008101153.GA1541@tentacle.sectorb.msk.ru> <1128967404.8195.419.camel@cog.beaverton.ibm.com> <20051010181216.GA21548@tentacle.sectorb.msk.ru> <434AB0BE.3080206@mysql.com> <20051011073532.GA29254@tentacle.sectorb.msk.ru>
In-Reply-To: <20051011073532.GA29254@tentacle.sectorb.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir B. Savkin wrote:
> On Mon, Oct 10, 2005 at 08:19:42PM +0200, Jonas Oreland wrote:
> 
>>Hi,
>>
>>check http://bugzilla.kernel.org/show_bug.cgi?id=5283
> 
> 
> Excuse me for possibly dumb question, but is it safe to leave TSCs
> unsynchronized when using other time source?
> How will other subsystems e.g. traffic queueing disciplines react?

Excuse me for possibly dumb answer: (i'm not a kernel hacker)

yes, I would guess that this will be handled as any other 
SMP machine where TSCs arent in sync.

/Jonas
