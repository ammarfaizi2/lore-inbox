Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284850AbRLZSmp>; Wed, 26 Dec 2001 13:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbRLZSmg>; Wed, 26 Dec 2001 13:42:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41995 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284831AbRLZSm3>; Wed, 26 Dec 2001 13:42:29 -0500
Subject: Re: Kernel crash with knfsd
To: dave@rudedog.org (Dave Carrigan)
Date: Wed, 26 Dec 2001 18:52:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87heqdanpx.fsf@pdaverticals.com> from "Dave Carrigan" at Dec 26, 2001 09:35:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JJAK-0002hB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The server is running 2.4.16 with XFS patches. The nfs-exported
> directories are both xfs and rieserfs. The laptop runs kernel autofs,
> and probably would have both of the server's xfs and reiserfs
> filesystems mounted at suspend time, because Nautilus tends to keep some
> filesystems permanently mounted.

Can you duplicate the problem with a base kernel not an XFS hacked one ?
Thats important info to know whether its an XFS patch bug or a core kernel
bug you are somehow tripping
