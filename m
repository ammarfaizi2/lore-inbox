Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSGWGqj>; Tue, 23 Jul 2002 02:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317972AbSGWGqj>; Tue, 23 Jul 2002 02:46:39 -0400
Received: from spud.dpws.nsw.gov.au ([203.202.119.24]:253 "EHLO
	spud.dpws.nsw.gov.au") by vger.kernel.org with ESMTP
	id <S317971AbSGWGqj>; Tue, 23 Jul 2002 02:46:39 -0400
Message-Id: <sd3d8929.020@out-gwia.dpws.nsw.gov.au>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Tue, 23 Jul 2002 16:49:15 +1000
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


Hi,
Thanks for your prompt response.
The /proc/mounts does NOT show any loopback devices. I have however,
umounted 3 FS but it still failed with same messages??

Daniel


>>> Thunder from the hill <thunder@ngforever.de> 23/07/2002 16:34:28
>>>
Hi,

On Tue, 23 Jul 2002, Daniel Lim wrote:
> # mkinitrd /boot/initrd-2.4.9-34.img 2.4.9-34
> All of your loopback devices are in use!

Yes, if all your loopback devices are in use, you'll have to umount
some. 
cat /proc/mounts, and there umount some of the filesystems with the
loop 
option.

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/ 



 This e-mail message (and attachments) is confidential, and / or privileged and is intended for the use of the addressee only. If you are not the intended recipient of this e-mail you must not copy, distribute, take any action in reliance on it or disclose it to anyone. Any confidentiality or privilege is not waived or lost by reason of mistaken delivery to you. DPWS is not responsible for any information not related to the business of DPWS. If you have received this e-mail in error please destroy the original and notify the sender.

For information on services offered by DPWS, please visit our website at www.dpws.nsw.gov.au



