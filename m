Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135328AbRD3Sei>; Mon, 30 Apr 2001 14:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135516AbRD3Se2>; Mon, 30 Apr 2001 14:34:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19721 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135328AbRD3SeS>; Mon, 30 Apr 2001 14:34:18 -0400
Subject: Re: Can the kernel access /?
To: madmatt@bits.bris.ac.uk (Matt)
Date: Mon, 30 Apr 2001 19:35:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104271521540.21006-100000@bits.bris.ac.uk> from "Matt" at Apr 27, 2001 03:28:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uIWF-0008Lo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can the driver pull the file from the filesystem if I were to pass the
> path of the file as an argument on loading the module?

Yes but its a bad idea. You dont want to force pathnames into the kernel

