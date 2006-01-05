Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWAEHxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWAEHxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWAEHxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:53:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18138 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750720AbWAEHxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:53:48 -0500
Date: Thu, 5 Jan 2006 08:53:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ben Collins <ben.collins@ubuntu.com>
cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/15] Ubuntu patch sync
In-Reply-To: <1136412768.4430.28.camel@grayson>
Message-ID: <Pine.LNX.4.61.0601050848570.10161@yvahk01.tjqt.qr>
References: <0ISL003P992UCY@a34-mta01.direcway.com> <20060104140627.1e89c185@dxpl.pdx.osdl.net>
 <1136412768.4430.28.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > These patches are just attempts to merge code from the ubuntu kernel tree.
>> > This is most of the differences between our tree and stock code (not
>> > necessarily all differences, since we do have a lot of external drivers
>> > pulled in).
>> 
>> Why not submit them too?
>
>Because neither I nor Ubuntu maintains them as upstream. I would rather
>leave it to the upstream authors of those drivers (e.g. rt2400, rt2500,
>unionfs, etc.) to submit their own code to Linus.

The maximum where unionfs should IMO go ATM is -mm, because it still has 
refcount issues and occassional crashes.

rt2400/etc is a bit more tricky. There exist several versions and they 
all have different levels of evolution :-/
 Group 1:
 - rt* from ralink.com.tw
 Group 2:
 - rt2400,rt2500,rt2570 "1.1.0" from sf.net/projects/rt2400
 - rt2x00 "2.0", also sf.net/projects/rt2400

Nevertheless, I do have rt* 1.1 and 2.0, and unionfs in my patchset...


Jan Engelhardt
-- 
