Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbVJKHfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbVJKHfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 03:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVJKHfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 03:35:39 -0400
Received: from tentacle.b.gz.ru ([217.67.124.4]:42957 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S1751402AbVJKHfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 03:35:38 -0400
Date: Tue, 11 Oct 2005 11:35:32 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Jonas Oreland <jonas@mysql.com>
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       discuss@x86-64.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Message-ID: <20051011073532.GA29254@tentacle.sectorb.msk.ru>
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20051007122624.GA23606@tentacle.sectorb.msk.ru> <200510071431.47245.ak@suse.de> <20051008101153.GA1541@tentacle.sectorb.msk.ru> <1128967404.8195.419.camel@cog.beaverton.ibm.com> <20051010181216.GA21548@tentacle.sectorb.msk.ru> <434AB0BE.3080206@mysql.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <434AB0BE.3080206@mysql.com>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.13.3
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 08:19:42PM +0200, Jonas Oreland wrote:
> Hi,
> 
> check http://bugzilla.kernel.org/show_bug.cgi?id=5283

Excuse me for possibly dumb question, but is it safe to leave TSCs
unsynchronized when using other time source?
How will other subsystems e.g. traffic queueing disciplines react?

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

