Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbRGPMpz>; Mon, 16 Jul 2001 08:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbRGPMpp>; Mon, 16 Jul 2001 08:45:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63752 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267340AbRGPMpg>; Mon, 16 Jul 2001 08:45:36 -0400
Subject: Re: Linux 2.4.6-ac4
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Mon, 16 Jul 2001 13:45:53 +0100 (BST)
Cc: laughing@shared-source.org, linux-kernel@vger.kernel.org
In-Reply-To: <200107161158.NAA09324@harpo.it.uu.se> from "Mikael Pettersson" at Jul 16, 2001 01:58:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15M7l3-0005Sp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> indicates a real bug (passing a pointer to int instead of the int itself).
> The patch below fixes this bug and silences the other two warnings.

The pci ones I've already fixed. I merged the wrong diff version of my changes
into the -ac tree. ac5 will fix that. I've merged the bluesmoke diff and 
hopefully fixed the bootflag oops
