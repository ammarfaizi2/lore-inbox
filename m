Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSDWJki>; Tue, 23 Apr 2002 05:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315121AbSDWJkh>; Tue, 23 Apr 2002 05:40:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9482 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315120AbSDWJkg>; Tue, 23 Apr 2002 05:40:36 -0400
Subject: Re: PDC20268 TX2 support?
To: linux@cabbey.net (Chris Abbey)
Date: Tue, 23 Apr 2002 10:58:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204201226530.25636-100000@tweedle.cabbey.net> from "Chris Abbey" at Apr 20, 2002 12:33:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16zx49-0008Fx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The fasttrak also has hardware raid, while it works, it works realtively
> well.

I believe its software. Its just concealed from the OS (windows)

> The current 2.4.18 code recognizes the card and provides vanilla IDE
> access to the drives, unfortunately that isn't much use unless someone
> wants to try and RE their block allocation on the disks... a decidedly
> non-trivial endeavour I can assure you. ;(

We have some ata raid support (drivers/ide/ataraid*) because people are
working on this.

