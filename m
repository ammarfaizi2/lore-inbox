Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKRF6D>; Sat, 18 Nov 2000 00:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQKRF5x>; Sat, 18 Nov 2000 00:57:53 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:43047 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129097AbQKRF5l>; Sat, 18 Nov 2000 00:57:41 -0500
Message-ID: <3A161337.6A1BE826@linux.com>
Date: Fri, 17 Nov 2000 21:27:19 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6 still very broken
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <8v4306$sga$1@cesium.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------47DCF7274FA76D6EE5CB8C99"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------47DCF7274FA76D6EE5CB8C99
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > The mysterious lockups in test11-pre5 continue in test11-pre6. It is very
> > difficult because the lockups appear to be kdb-specific (and kdb itself

[...]

> It could be that -test5 and -test6 break some assumption kdb makes.
> It has been eminently stable here.

Whether or not the assumptions are made, the last testN series of kernels have
introduced two serious issues IMO.  The first is the mysterious deadlocks and
no way to figure them out.  With kdb the machine won't hang.  Without it, it
deadlocks within 36 hours.

The second issue is usb.  I now have two machines that lockup on boot in USB.
One is the above workstation, the second is a Compaq laptop.  Unfortunately
I have no way of unplugging the USB hardware inside the laptop :P

-d


--------------47DCF7274FA76D6EE5CB8C99
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------47DCF7274FA76D6EE5CB8C99--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
