Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267040AbRGYWAe>; Wed, 25 Jul 2001 18:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbRGYWAY>; Wed, 25 Jul 2001 18:00:24 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:58402 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266967AbRGYWAM>; Wed, 25 Jul 2001 18:00:12 -0400
Date: Wed, 25 Jul 2001 18:00:18 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107252200.f6PM0IJ01020@devserv.devel.redhat.com>
To: john@vnet.ibm.com, <LINUX-KERNEL@vger.kernel.org>
Subject: Re: Reserving large amounts of RAM for busmastering PCI card.
In-Reply-To: <mailman.996053899.5490.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.996053899.5490.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>  Since the 2.4 kernels introduce the e820map structure, I'd like to
>  plug into that infrastructure, and create a new type memory segment
>  for this storage (I envisage having more than one segment), but in the
>  2.4.4 kernel (which I am forced to remain with for quite a while) it
>  seems not to be used apart from set up at boot time.

Stop reinventing the wheel and take Matt & Pauline's bigphisarea.
 http://www.polyware.nl/~middelink/patch/bigphysarea-2.4.4.tar.gz

-- Pete
