Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132490AbQK3BDj>; Wed, 29 Nov 2000 20:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132489AbQK3BD3>; Wed, 29 Nov 2000 20:03:29 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:16423 "EHLO
        nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
        id <S132428AbQK3BDX>; Wed, 29 Nov 2000 20:03:23 -0500
Message-ID: <3A255DC2.C05701D2@linux.com>
Date: Wed, 29 Nov 2000 11:49:22 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [bug] floppy spins w/out end after apm resume
Content-Type: multipart/mixed;
 boundary="------------0DD66AB90204FBBEB2A4E6FD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0DD66AB90204FBBEB2A4E6FD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

yet another apm related bug.  this one is the odd one, frequently i
update my kernel on this laptop.  every once in a while, i'd say about
one out of five kernels..upon apm resume, the floppy drive motor will
start spinning.  nothing stops it from spinning except i attempt to
mount a non-existing filesystem on it.  putting a floppy in and ejecting
it doesn't fix it.

the current kernel is test12-2, exact same config as the test11. any
ideas?

-d


--------------0DD66AB90204FBBEB2A4E6FD
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

--------------0DD66AB90204FBBEB2A4E6FD--



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
