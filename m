Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131353AbRDCM2U>; Tue, 3 Apr 2001 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRDCM2N>; Tue, 3 Apr 2001 08:28:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20485 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131657AbRDCM1v>; Tue, 3 Apr 2001 08:27:51 -0400
Subject: Re: /proc/config idea
To: dlang@diginsite.com (David Lang)
Date: Tue, 3 Apr 2001 13:27:26 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), jerj@coplanar.net (Jeremy Jackson),
        ian@cs.umbc.edu (Ian Soboroff), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104021951450.30568-100000@dlang.diginsite.com> from "David Lang" at Apr 02, 2001 07:52:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kPuE-0007xK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a module for 2.4.3 will work for any 2.4.3 kernel that supports modules
> at all (except for the SMP vs UP issue) so it's not the same thing as
> trying to figure out which if the 2.4.3 kernels matches what you are
> running.

Nope. The 2.4 kernel ABI depends upon a mixture of config options including the
cpu type, as well as the compiler version being used. The API is intended to
be constant throughout 2.4 (but isnt yet totally solid due to bug fixing
activity). We don't care about the ABI because we are source code based

