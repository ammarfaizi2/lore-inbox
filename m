Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBMSVV>; Tue, 13 Feb 2001 13:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbRBMSVM>; Tue, 13 Feb 2001 13:21:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129092AbRBMSVD>;
	Tue, 13 Feb 2001 13:21:03 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102131720.f1DHKjs02676@flint.arm.linux.org.uk>
Subject: Re: How to install Alan's patches?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 13 Feb 2001 17:20:45 +0000 (GMT)
Cc: puckwork@madz.net (Thomas Foerster), linux-kernel@vger.kernel.org
In-Reply-To: <E14ShMU-000241-00@the-village.bc.nu> from "Alan Cox" at Feb 13, 2001 03:27:25 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> cd linux
> patch -p1 <../patchfile

patch -p1 -i ../patchfile means that patch won't read the whole patchfile
into a temporary file first, which it will do if patch reads from stdin.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

