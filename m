Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261280AbRELQrT>; Sat, 12 May 2001 12:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261282AbRELQrJ>; Sat, 12 May 2001 12:47:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3858 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261280AbRELQrD>; Sat, 12 May 2001 12:47:03 -0400
Subject: Re: ENOIOCTLCMD?
To: jlundell@pobox.com (Jonathan Lundell)
Date: Sat, 12 May 2001 17:43:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <p05100305b722fde7cf26@[207.213.214.37]> from "Jonathan Lundell" at May 12, 2001 07:52:28 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ycUa-0004K0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's what's confusing me: why the distinction? It's true that the 
> current scheme allows the dev->ioctlfunc() call below to force ENOTTY 
> to be returned, bypassing the switch, but presumably that's not what 
> one wants.

It allows driver specific code to override generic code, including by reporting
that a given feature is not available/appropriate.

Alan

