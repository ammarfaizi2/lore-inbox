Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSFERYi>; Wed, 5 Jun 2002 13:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSFERYh>; Wed, 5 Jun 2002 13:24:37 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:22123 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S315630AbSFERYg>; Wed, 5 Jun 2002 13:24:36 -0400
Date: Wed, 5 Jun 2002 13:20:18 -0400
From: William Thompson <wt@electro-mechanical.com>
To: linux-kernel@vger.kernel.org
Subject: promise PDC20267 onboard supermicro P3TDDE
Message-ID: <20020605132018.A4803@coredump.electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I boot linux on this system and there is a disk attached to the promise
connector, the system hard locks.  It finds the PDC20267 and the Via ide
chipsets (in that order) and freezes here.  It doesn't show anything else.

I tried kernels 2.4.18 and 2.4.19-pre10.

I also tried making ide a module, loading ide-mod.o freezes as well.

Removing the hdd from the controller and it boots just fine.  I tried a
Quantum fireball lct10 05 and a seagate st34311a with the same results.

The bios on the pdc controller is v1.31
