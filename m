Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317975AbSGWG7l>; Tue, 23 Jul 2002 02:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317976AbSGWG7l>; Tue, 23 Jul 2002 02:59:41 -0400
Received: from spud.dpws.nsw.gov.au ([203.202.119.24]:52733 "EHLO
	spud.dpws.nsw.gov.au") by vger.kernel.org with ESMTP
	id <S317975AbSGWG7k>; Tue, 23 Jul 2002 02:59:40 -0400
Message-Id: <sd3d8c36.078@out-gwia.dpws.nsw.gov.au>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Tue, 23 Jul 2002 17:02:23 +1000
From: "Daniel Lim" <Daniel.Lim@dpws.nsw.gov.au>
To: <thunder@ngforever.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mkinitrd problem
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thanks again,
I have this 
# ls -l /dev/loop*
brw-rw----    1 root     disk       7,   0 Jul 23 16:06 /dev/loop0
brw-rw----    1 root     disk       7,   1 Jul 23 16:06 /dev/loop1
brw-rw----    1 root     disk       7,  10 Jul 23 16:06 /dev/loop10
brw-rw----    1 root     disk       7,  11 Jul 23 16:06 /dev/loop11
brw-rw----    1 root     disk       7,  12 Jul 23 16:06 /dev/loop12
brw-rw----    1 root     disk       7,  13 Jul 23 16:06 /dev/loop13
brw-rw----    1 root     disk       7,  14 Jul 23 16:06 /dev/loop14
brw-rw----    1 root     disk       7,  15 Jul 23 16:06 /dev/loop15
brw-rw----    1 root     disk       7,   2 Jul 23 16:06 /dev/loop2
brw-rw----    1 root     disk       7,   3 Jul 23 16:06 /dev/loop3
brw-rw----    1 root     disk       7,   4 Jul 23 16:06 /dev/loop4
brw-rw----    1 root     disk       7,   5 Jul 23 16:06 /dev/loop5
brw-rw----    1 root     disk       7,   6 Jul 23 16:06 /dev/loop6
brw-rw----    1 root     disk       7,   7 Jul 23 16:06 /dev/loop7
brw-rw----    1 root     disk       7,   8 Jul 23 16:06 /dev/loop8
brw-rw----    1 root     disk       7,   9 Jul 23 16:06 /dev/loop9



>>> Thunder from the hill <thunder@ngforever.de> 23/07/2002 16:54:02
>>>
Hi,

On Tue, 23 Jul 2002, Daniel Lim wrote:
> The /proc/mounts does NOT show any loopback devices. I have however,
> umounted 3 FS but it still failed with same messages??

It was about umounting loop filesystems...

What do you have in /dev/loop (devfs), or what /dev/loopx devices (no 
devfs, ls /dev/loop*) do you have?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------



 This e-mail message (and attachments) is confidential, and / or privileged and is intended for the use of the addressee only. If you are not the intended recipient of this e-mail you must not copy, distribute, take any action in reliance on it or disclose it to anyone. Any confidentiality or privilege is not waived or lost by reason of mistaken delivery to you. DPWS is not responsible for any information not related to the business of DPWS. If you have received this e-mail in error please destroy the original and notify the sender.

For information on services offered by DPWS, please visit our website at www.dpws.nsw.gov.au



