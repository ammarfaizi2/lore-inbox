Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292355AbSBBTVd>; Sat, 2 Feb 2002 14:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292356AbSBBTV3>; Sat, 2 Feb 2002 14:21:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24082 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292355AbSBBTVM>; Sat, 2 Feb 2002 14:21:12 -0500
Subject: Re: PF_UNIX socket problem in 2.4
To: mp292@cam.ac.uk (Matej Pfajfar)
Date: Sat, 2 Feb 2002 19:33:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.33.0202021429060.6-100000@orange.csi.cam.ac.uk> from "Matej Pfajfar" at Feb 02, 2002 02:29:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16X5v4-0000H9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After upgrading to kernel 2.4.18pre7 (from 2.2.19), a recv() operation on
> a UNIX socket returns 11 (EGAIN) even though the socket is blocking. My
> code worked fine on 2.2.19.
> 
> I am doing some more debugging to see why this happens but I would like to
> ask whether anyone else has had similar problems? Is this a known bug?

Not a known one. A small test case would be good
