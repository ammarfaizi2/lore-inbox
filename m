Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132281AbRADJ7M>; Thu, 4 Jan 2001 04:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132483AbRADJ7C>; Thu, 4 Jan 2001 04:59:02 -0500
Received: from james.kalifornia.com ([208.179.0.2]:21855 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S132281AbRADJ6p>; Thu, 4 Jan 2001 04:58:45 -0500
Message-ID: <3A54494D.C7DA0455@linux.com>
Date: Thu, 04 Jan 2001 01:58:37 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.0-release (and a few priors) stalls
Content-Type: multipart/mixed;
 boundary="------------94382961CC0941B74C2ABEF4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------94382961CC0941B74C2ABEF4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Recently, about test 12 I believe, I started experiencing stalls.
I believe it has to do with VM pressure but I'm not sure.

What happens:  5-60 second instant dead stall, nothing at all happens.
No sound/key/disk/anything activity, screen updates stop in the middle
of an update.  Until recently I was mistaking this as a lockup and
rebooting (thank you reiserfs).  Now I just wait it out.  I'm away for
holiday/vacation so I can't hookup kbd. :(

Environment: normally swap is full -but- buffers can have any amount of
free listed, sometimes well over 100 megs.

After the stall resumes, everything starts right up and sings along
fine.  There aren't any kernel messages indicating something was funny.

This is different from running out of normal pages, the system starts to
thrash and slows considerably, almost unusable, but over a period of
10-20 seconds.  If I add swap quickly, X won't get killed.
(unfortunately, X seems to get killed 9/10 times because netscape took
too long to die so the kernel kept killing).

-d


--------------94382961CC0941B74C2ABEF4
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

--------------94382961CC0941B74C2ABEF4--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
