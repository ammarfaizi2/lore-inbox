Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWCLRA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWCLRA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWCLRA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:00:59 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:40793 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751569AbWCLRA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:00:58 -0500
Date: Sun, 12 Mar 2006 11:00:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Problem with a CD
In-reply-to: <5PBCr-4pd-21@gated-at.bofh.it>
To: Eric.Brunet@lps.ens.fr
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <441453BE.60002@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5PBCr-4pd-21@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric.Brunet@lps.ens.fr wrote:
> I have error messages in my logs:
> on computer #1, they look like:
> |hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> |hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
> |ide: failed opcode was: unknown
> |end_request: I/O error, dev hdc, sector 5008
> |Buffer I/O error on device hdc, logical block 1252
> on computer #2, they are simpler:
> |end_request: I/O error, dev sr0, sector 5008
> |Buffer I/O error on device sr0, logical block 1252
> 
> On both computers, I have the errors on the same sectors/blocks.
> 
> For the two offending files, the errors already occur on the beginings of
> the files.
> 
> Of course, all of this point to a defective CD, except that on both
> computers, I can read the files without any problem with windows XP
> (well, actually, I have only read avseq01.dat, which is a video file. I
> haven't tried the other troublesome file.)
> 
> What could be the problem ?

This is a VCD, right? Those use Mode 2 Form 2 which has weak error 
correction (like an audio CD). It's possible the drive is returning read 
errors and WinXP is ignoring the errors because it's a VCD, and Linux is 
not..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

