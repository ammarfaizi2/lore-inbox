Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281964AbRKUTxE>; Wed, 21 Nov 2001 14:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281963AbRKUTwy>; Wed, 21 Nov 2001 14:52:54 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:6788 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281961AbRKUTwj>; Wed, 21 Nov 2001 14:52:39 -0500
Message-ID: <002101c172c5$f2040cc0$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Doug Ledford" <dledford@redhat.com>
Cc: <arjan@fenrus.demon.nl>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl> <002401c172ba$b46bed20$f5976dcf@nwfs> <3BFBFB4F.8090403@redhat.com>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 12:51:43 -0700
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

Doug,

I have seen some problems with the rpm build and default install of your
kernel sources.
NWFS and the SCI drivers will **NOT** build against it since you post in a
linux and linux-up kernel for lilo during boot.  People using these drivers
who email me always have to do a "make distclean" to get stuff to build.  I
am very familiar with the kernel.h
changes you guys put in that are different from stock kernels, but despite
this, it's
far from "plug and play" for a customer building third party kernel modules
on your rpms.
I am not saying this is bad or anything, but it does require that the
customer A) have a
Linux consultant to do the installation or B) be a competent Linux
programmer.  Kind of
tough this to expect a secretary to do without a little help.

This is way off topic at this point.  This was originally related to BUG()
getting called from builds against a virgin source tree.  Alan Cox has asked
me to look into the code and determine just where the BUG() message is
getting generated from.  I am pursuing this at present.

Jeff

:-)

Jeff

