Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262275AbRENRGr>; Mon, 14 May 2001 13:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbRENRGh>; Mon, 14 May 2001 13:06:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30726 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262325AbRENRGS>; Mon, 14 May 2001 13:06:18 -0400
Subject: Re: [Re: Inodes]
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 14 May 2001 18:02:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9dovmu$eqj$1@cesium.transmeta.com> from "H. Peter Anvin" at May 14, 2001 09:04:46 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zLjz-0000zd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The inode numbers are "invented" by the MS-DOS filesystem driver.  In
> the particular case of the "msdos" driver I believe it uses the
> location of the directory entry (the functional equivalent of the
> inode) on disk.

They are generated basically at random with a uniqueness test and may change
once nobody is referencing the inode. Directory entry breaks across rename..
