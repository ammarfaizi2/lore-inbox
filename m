Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288435AbSANJH3>; Mon, 14 Jan 2002 04:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288595AbSANJHT>; Mon, 14 Jan 2002 04:07:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22800 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288435AbSANJHG>; Mon, 14 Jan 2002 04:07:06 -0500
Subject: Re: Alans example against preemtive kernel (Was: Re: [2.4.17/18pre] VM and swap - it's really unusable)
To: roger.larsson@norran.net (Roger Larsson)
Date: Mon, 14 Jan 2002 09:18:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <200201140725.g0E7PkT22694@mailb.telia.com> from "Roger Larsson" at Jan 14, 2002 08:22:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Q3GS-00017j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This should be mostly OK for the preemptive kernel. Swapping the irq an=
> d spin=20
> lock lines should be preferred. But I think that is the case in SMP too=
> =2E..

You deadlock if you swap the two lines over. In this case for pre-empt you
really have to go in and add non pre-emption places to the driver
