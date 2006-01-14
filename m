Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWANUYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWANUYY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWANUYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:24:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751062AbWANUYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:24:23 -0500
Date: Sat, 14 Jan 2006 12:24:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI update for 2.6.15
In-Reply-To: <1137268015.3579.14.camel@mulgrave>
Message-ID: <Pine.LNX.4.64.0601141215400.13339@g5.osdl.org>
References: <1137268015.3579.14.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jan 2006, James Bottomley wrote:
>
> This should represent the final pieces of SCSI for the merge window.

This is a final warning.

If the next SCSI merge tries to come in the day before the release window 
closes, I WILL SIMPLY IGNORE IT, and the damn thing can wait until next 
release.

We discussed this last time around. You guys had SIX WEEKS of calming-down 
time during the last tree to do your SCSI development. Instead, you're 
apparently AGAIN trying to cram it into the two weeks when merges are 
supposed to happen, and then going in under the radar the day before I'm 
about to do a -rc1, so that we won't have any time at all to fix even 
obvious problems, is not how it's supposed to work.

So as far as big SCSI merges (and I'm seriously considering this same 
policy for networking too, because it worked so badly this time around) is 
concerned, they'd better be ready in the _first_ week of the two-week 
window, simply because I'm fed up with this last-minute thing.

The point of having a TWO WEEK merge window is not that you use two weeks 
for development, and then merge the last possible chance. Not at all. The 
point of giving people two weeks is so that people don't have to be 
totally synchronized - somebody can be on vacation, some problem could 
have cropped up that people wanted fixed first, etc etc.

So next time around: merge in the first week. And you can merge more than 
once, so if there's something missing MERGE ANYWAY, for christ sake! Then, 
if you have a small further feature the last day, at least it's _small_, 
and most of the new stuff has been getting some testing.

I'm pissed off. No more of these "developer limbo dance" games. I thought 
it was clear last time around. 

And hell yes, I'm serious. The SCSI merge window next time is one week. 
Not a day more. After that first week, you get an additional _smaller_ 
merge window of another week for smaller new features. Because I'm not 
going to take this a third time in a row.

			Linus
