Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310913AbSCROGt>; Mon, 18 Mar 2002 09:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310920AbSCROGi>; Mon, 18 Mar 2002 09:06:38 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:40939 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S310913AbSCROGY> convert rfc822-to-8bit; Mon, 18 Mar 2002 09:06:24 -0500
Importance: Normal
Sensitivity: 
Subject: Re: 2.4.19-pre3 s390 memorandum
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF2734EA62.9BBA966E-ONC1256B80.00382912@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 18 Mar 2002 15:03:36 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 18/03/2002 15:06:13
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

>thanks for taking action and sending updates for 2.4.19-pre3.
>I am happy to report that it generally works, and with the
>partition code it recognises ECKD volumes.

Good!

>I would very much prefer if you sent future updates in plain
>diff -u to linux-kernel too. I appreciate tarballs that you
>sent to me, but this is not quite what would prevent broken
>kernels in the future [it helps Red Hat to ship working kernels,
>but it does not help Marcelo]. As it was with 2.4.18, Marcelo
>has no choice but to accept all code that belongs to your
>authority and to fail every else, producing inconsistency.
>Posting to linux-kernel beforehand is supposed to start a
>discussion that may guide Marcelo to accept changes to generic code.
>I will send the example with the partition code immediately.

I certainly can post our patches to linux-kernel but in general
they are way to big for the newsgroup. For example the rework of
s390io.c (not yet finished) is already about 12K lines. I'd say
to big for linux-kernel. We usually post problems with common
code on linux-kernel. I dunno about the partition problem. I
might have sent the patch only to Al Viro but at the moment
I am too lazy to check..

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


