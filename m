Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbQLHEC6>; Thu, 7 Dec 2000 23:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQLHECt>; Thu, 7 Dec 2000 23:02:49 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:34052 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129707AbQLHECk>; Thu, 7 Dec 2000 23:02:40 -0500
Message-ID: <3A30552D.A6BE248C@timpanogas.org>
Date: Thu, 07 Dec 2000 20:27:41 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: NTFS repair tools]
Content-Type: multipart/mixed;
 boundary="------------1995765541A26C2D8C9BF9DA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1995765541A26C2D8C9BF9DA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Linux/Linus/Anton/Alan,

I am still sending out the NTFS repair tools for Linux trashed volumes,
and I've lost count now relative to how many I've sent out, but it's
somewhere in the thousands.  Is NTFS write stable enough now in 2.4 to
fix these problems, if so, can we DISABLE by REMOVING write code in the
VFS tables for those versions in other trees we know will trash people's
drives.  I am sending out over 100 copies a week now (I could make a
business out of fixing NTFS drives trashed by Linux) and the numbers are
getting higher instead of lower of people asking for these tools, which
woul indicate more people's data is getting trashed.

Do folks not know this NTFS driver will trash hard drives?  We need to
alert folks DO NOT USE WRITE NTFS MODE in those versions we know are
busted.  I enjoy helping NT customers get their data back and helping
with this problem, but at some point, the NTFS driver either needs to
get sync'd or WRITE disabled.  What I'm doing here is like trying to put
a bandaid over the mouth of the amazon river, and as Linux grows and
grows and grows, this problem will just get larger, and to a point where
I don't have the bandwidth to support it properly.

I will keep providing this service, but I am only treating the symptons
of the illness and not curing the patient.  Based upon the level of
contamination of TRG with Microsoft IP, I have been advised if I post an
NTFS replacement before the 18 month doctrine of inevitability "window"
is past, Microsoft will most certainly sue us, and win.

I strongly recommend stubbing our the file_write() calls in the NTFS VFS
until this gets fixed, until I can get working NTFS out there, or Anton
can get one out there (which will be another year and a half if it comes
from us based on the agreements we have with Microsoft).

:-)

Jeff
--------------1995765541A26C2D8C9BF9DA
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-Path: <lynn@mail.earth.monash.edu.au>
Received: from mail.earth.monash.edu.au (orion.earth.monash.edu.au [130.194.168.8])
	by vger.timpanogas.org (8.9.3/8.9.3) with ESMTP id VAA01591
	for <jmerkey@timpanogas.com>; Thu, 7 Dec 2000 21:10:33 -0700
Received: from rama.earth.monash.edu.au (rama.earth.monash.edu.au [130.194.168.65])
	by mail.earth.monash.edu.au (8.9.3/8.9.3) with ESMTP id OAA09776
	for <jmerkey@timpanogas.com>; Fri, 8 Dec 2000 14:14:01 +1100 (EDT)
Received: from mail.earth.monash.edu.au (localhost [127.0.0.1])
	by rama.earth.monash.edu.au (8.9.3/8.9.3) with ESMTP id OAA13777
	for <jmerkey@timpanogas.com>; Fri, 8 Dec 2000 14:13:59 +1100 (EST)
Sender: lynn@mail.earth.monash.edu.au
Message-ID: <3A3051F5.1D16ADB0@mail.earth.monash.edu.au>
Date: Fri, 08 Dec 2000 14:13:58 +1100
From: Lynn Evans <lynn@mail.earth.monash.edu.au>
X-Mailer: Mozilla 4.5 [en] (X11; I; OSF1 V4.0 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: jmerkey@timpanogas.com
Subject: NTFS repair tools
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by vger.timpanogas.org id VAA01591
X-Mozilla-Status2: 00000000

I have been using a PC which dual boots Linux/NT. Linux
seems to have trashed the ntfs partition when it ran out of
space while writing to it. The partition is data only but
was not backed up.
A search on the net indicated that this is a common problem
and that you may be able to point me at or provide tools
which could help repair the partition.
I would be grateful for any help,
Lynn

--

________________________________
Lynn Evans
Department of Earth Sciences
P.O. Box 28E
Monash University
Melbourne, VIC 3800 Australia

Phone +61 (3) 9905 1527
Fax   +61 (3) 9905 4903
Lynn.Evans@sci.monash.edu.au
________________________________


--------------1995765541A26C2D8C9BF9DA--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
