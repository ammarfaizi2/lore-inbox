Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWBDTDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWBDTDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWBDTDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:03:36 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10220 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751530AbWBDTDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:03:36 -0500
Subject: Re: athlon 64 dual core tsc out of sync
From: Lee Revell <rlrevell@joe-job.com>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43E40D14.7070606@comcast.net>
References: <43E40D14.7070606@comcast.net>
Content-Type: text/plain
Date: Sat, 04 Feb 2006 14:03:31 -0500
Message-Id: <1139079812.2791.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 21:10 -0500, Ed Sweetman wrote:
> I know this has been gone over before, and I am aware of the possible 
> fix being the use of the pmtmr.
> 
> My question is, if there is support builtin to the kernel for more than 
> one timer, and we know that no timer but the pmtimer is reliable on a 
> dual core system, why doesn't the startup of the kernel choose the 
> pmtimer based on if it detects the system is a dual core proc with smp 
> enabled?   And if the pmtimer doesn't fix this sync issue, is there a 
> fix out there?   Currently with 2.6.16-rc1-mm5 the non-customized boot 
> args to the kernel results in these messages.

Excellent question.  What's the status of this bug?  It's a showstopper
for a ton of people on the JACK list...

Lee

