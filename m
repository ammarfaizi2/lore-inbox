Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbVFXPbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVFXPbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbVFXPbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:31:53 -0400
Received: from dvhart.com ([64.146.134.43]:14770 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S263025AbVFXPbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:31:49 -0400
Date: Fri, 24 Jun 2005 08:31:45 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <23340000.1119627105@[10.10.2.4]>
In-Reply-To: <200506250014.26504.kernel@kolivas.org>
References: <208690000.1119330454@[10.10.2.4]> <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]> <200506250014.26504.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Con Kolivas <kernel@kolivas.org> wrote (on Saturday, June 25, 2005 00:14:26 +1000):

> On Sat, 25 Jun 2005 00:11, Martin J. Bligh wrote:
>> --Andrew Morton <akpm@osdl.org> wrote (on Tuesday, June 21, 2005 13:03:44 
> -0700):
>> > "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> >> Or I guess it's binary chop
>> >>  search amongst sched patches (or at least the ones that are new in
>> >>  this -mm ?)
>> > 
>> > Yes please.
>> 
>> OK, still broken with the last 3 backed out, but works with the last
>> 4 backed out. So I guess it's scheduler-cache-hot-autodetect.patch
>> that breaks it. Con just sent me something else to try to fix it in order
>> to run next ... will do that.
> 
> Sorry, that patch I sent isn't a fix for any known problem, it's another tweak 
> to my code. If you have breakage elsewhere don't waste your time with my code 
> just yet.

OK, I'll stack that on top of backing out the last 4 patches, which fixed moe.

M.

