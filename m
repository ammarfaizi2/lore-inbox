Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281476AbRKUS3s>; Wed, 21 Nov 2001 13:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281942AbRKUS3i>; Wed, 21 Nov 2001 13:29:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:36227 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281451AbRKUS3d>; Wed, 21 Nov 2001 13:29:33 -0500
Message-ID: <001a01c172ba$4f35e460$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E166T4K-0004Lr-00@the-village.bc.nu>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 11:28:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>; <jmerkey@timpanogas.org>
Sent: Wednesday, November 21, 2001 1:49 AM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


> > Here's really strange one.  Building a module against 2.4.15-pre7
> > seems to generate invalid opcodes (???) from the kernel includes.
>
> You hit a BUG(). If you rebuild the kernel with verbose BUG reporting
> included you'll get a line and file to work back from

This may help me determine which include file is breaking the tree.  I know
I hit a
BUG() but I should not have.  Looks like a hole somewhere.  I will attempt
to track
this down today.

Jeff

