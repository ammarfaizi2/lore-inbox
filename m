Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266906AbRG1QXd>; Sat, 28 Jul 2001 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266914AbRG1QXX>; Sat, 28 Jul 2001 12:23:23 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:48819
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S266906AbRG1QXK>; Sat, 28 Jul 2001 12:23:10 -0400
Message-ID: <001001c11781$9db10a50$6baaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Richard Gooch" <rgooch@ras.ucalgary.ca>
Cc: "Martin Wilck" <Martin.Wilck@fujitsu-siemens.com>,
        "devfs mailing list" <devfs@oss.sgi.com>,
        "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0107272127060.16993-100000@biker.pdb.fsc.net><000701c116f5$8268a820$6baaa8c0@kevin> <200107281215.f6SCFt716350@mobilix.ras.ucalgary.ca>
Subject: Re: [PATCH]: ide-floppy & devfs
Date: Sat, 28 Jul 2001 09:23:20 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

<snip>
> Are you saying that the two patch conflict? If not, can someone please
> verify that both together are safe? Or is your patch a superset?
>

Actually, the patches are complementary. However, my patch I won't be
continuing to work on, as the entire way that partitions are
read/validated/passed to devfs/etc will be changed in 2.5, and I've already
forwarded this patch over to the maintainer of that code (whose name escapes
my memory at the moment). So I'd say don't worry about it from the devfs
end, you'll see the changes once 2.5 opens and these changes get merged in
to that tree.

