Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSEBPBi>; Thu, 2 May 2002 11:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314554AbSEBPBg>; Thu, 2 May 2002 11:01:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59147 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314548AbSEBPAh>; Thu, 2 May 2002 11:00:37 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
To: kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski)
Date: Thu, 2 May 2002 16:19:00 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205020913390.32217-100000@chaos.physics.uiowa.edu> from "Kai Germaschewski" at May 02, 2002 09:24:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173IMG-00047l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> possible that the ABI does not change but the checksum does. That happens 
> a lot, but it's not really a big problem because that (if done right) will 
> just cause spurious rebuilds - correctness isn't affected.

ccache is your friend on that one.

> Of course, for people who are patching their kernels a lot, modversions
> (again if done right) are a pain in the a**, since they cause a lot of not
> really necessary rebuilds. But people who do that supposedly think they

ccache is still your friend 8)

Alan
