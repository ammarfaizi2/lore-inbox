Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264717AbRGNSMx>; Sat, 14 Jul 2001 14:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbRGNSMn>; Sat, 14 Jul 2001 14:12:43 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:56841 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S264689AbRGNSMe>; Sat, 14 Jul 2001 14:12:34 -0400
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
Date: 14 Jul 2001 20:12:35 +0200
Organization: Cistron Internet Services
Message-ID: <9iq22j$7p5$1@picard.cistron.nl>
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu> <3B5083AE.71515696@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B5083AE.71515696@mandrakesoft.com>,
Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
>IMHO we have made an exception for glibc for long enough...

glibc and strace, which is already having a truely horrible time trying
to get the right data from the kernel includes. There is some
functionality deliberately missing from strace since the only way
to implement it would have been to copy things from the kernel includes
into the source which just adds extra maintenance nightmares.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

