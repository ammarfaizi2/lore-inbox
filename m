Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVF1Ew4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVF1Ew4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVF1Ew4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:52:56 -0400
Received: from smtpout.mac.com ([17.250.248.84]:11971 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262530AbVF1Ewi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:52:38 -0400
In-Reply-To: <20050627140549.1fbaf3e7.akpm@osdl.org>
References: <20050627131633.62af898b.rdunlap@xenotime.net> <20050627140549.1fbaf3e7.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F1345581-A5B4-4535-B6A5-1A48CC496728@mac.com>
Cc: randy_dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH -mm] Documentation/feature-removal-schedule.txt in date order
Date: Tue, 28 Jun 2005 00:52:27 -0400
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 27, 2005, at 17:05:49, Andrew Morton wrote:
> randy_dunlap <rdunlap@xenotime.net> wrote:
>> a.  arrange feature-removal items in date order
>
> I'm not sure that this will be very successful.  Every man and his  
> dog is
> patching this file - it's a major source of rejects for me and I  
> have a
> habit of sticking new records into random places just to avoid rejects
> against changes coming in from other trees.

Uhh, how about this?

Documentation/feature-removal-schedule/2005-07_devfs.txt
Documentation/feature-removal-schedule/2005-12_raw_driver.txt

On the plus side, no rejects, and significantly more readable diffs. On
the minus side, it causes many more files in the source tree, though it
does make it easier to sort by whatever takes your fancy.  grep works
better too. :-D

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't.  
That's why
I draw cartoons. It's my life."
-- Charles Shultz

