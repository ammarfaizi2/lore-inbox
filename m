Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132396AbRC1CSX>; Tue, 27 Mar 2001 21:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132408AbRC1CSM>; Tue, 27 Mar 2001 21:18:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4871 "EHLO the-village.bc.nu") by vger.kernel.org with ESMTP id <S132396AbRC1CSB>; Tue, 27 Mar 2001 21:18:01 -0500
Subject: Re: Larger dev_t
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 28 Mar 2001 03:19:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@transmeta.com (H. Peter Anvin), Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <Pine.LNX.4.31.0103271606420.25282-100000@penguin.transmeta.com> from "Linus Torvalds" at Mar 27, 2001 04:07:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14i5Y9-0004qx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Exactly. It's just that for historical reasons, I think the major for
> "disk" should be either the old IDE or SCSI one, which just can show more
> devices. That way old installers etc work without having to suddenly start
> knowing about /dev/disk0.

They will mostly break. Installers tend to parse /proc/scsi and have fairly
complex ioctl based relationships based on knowing ide v scsi.

/dev/disc/ is a little un-unix but its clean



