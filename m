Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130525AbQLBVPi>; Sat, 2 Dec 2000 16:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130468AbQLBVP2>; Sat, 2 Dec 2000 16:15:28 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:34868 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130525AbQLBVPW>; Sat, 2 Dec 2000 16:15:22 -0500
Message-ID: <3A295F27.D356DC91@linux.com>
Date: Sat, 02 Dec 2000 12:44:23 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Igmar Palsenberg <maillist@chello.nl>
CC: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Matthew Kirkwood <matthew@hairy.beasts.org>, folkert@vanheusden.com,
        "Theodore Y Ts'o" <tytso@mit.edu>,
        Kernel devel list <linux-kernel@vger.kernel.org>, vpnd@sunsite.auc.dk
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <Pine.LNX.4.21.0012022233440.11907-100000@server.serve.me.nl>
Content-Type: multipart/mixed;
 boundary="------------19F3DEECCACA37F26C51E5F2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------19F3DEECCACA37F26C51E5F2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Making /dev/random block if the amount requirements aren't met makes sense
> to me. If I request x bytes of random stuff, and get less, I probably
> reread /dev/random. If it's entropy pool is exhausted it makes sense to be
> to block.

This is the job of the program accessing /dev/random.  Open it blocking or
non-blocking and read until you satisfy your read buffer.

-d


--------------19F3DEECCACA37F26C51E5F2
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------19F3DEECCACA37F26C51E5F2--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
