Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRJPVoo>; Tue, 16 Oct 2001 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276745AbRJPVoe>; Tue, 16 Oct 2001 17:44:34 -0400
Received: from sushi.toad.net ([162.33.130.105]:13458 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276743AbRJPVo0> convert rfc822-to-8bit;
	Tue, 16 Oct 2001 17:44:26 -0400
Subject: Re: [PATCH] PnP BIOS patch against 2.4.12-ac2
From: Thomas Hood <jdthood@mail.com>
To: =?ISO-8859-1?Q?J=F6rg?= Ziuber <ziuber@ict.uni-karlsruhe.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BCBE89C.ADD98E21@ict.uni-karlsruhe.de>
In-Reply-To: <E15t6nz-000205-00@the-village.bc.nu>
	<1003202856.12542.57.camel@thanatos> 
	<3BCBE89C.ADD98E21@ict.uni-karlsruhe.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.15 (Preview Release)
Date: 16 Oct 2001 17:44:12 -0400
Message-Id: <1003268655.12542.67.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-16 at 03:58, Jörg Ziuber wrote:
> I tested the updated patch against 2.4.12-ac2 on a Sony Vaio PCG-FX205K.
> You can see in the appendix output, no oops.
> 
> But, one Problem:
> If I attach an USB device to the laptop it will not initialize and I get
> the kernel messages, you will find in the last 10 lines of the output.
> Amazing: If I cause permament traffic with a working device on IRQ 9
> (e.g. a ping via eth0), the USB device will be recognized and works,
> even though muuuuch slower.

Is this problem related to the PnP BIOS patch?  That is,
do you have the same problem with a kernel that lacks the
patch?


