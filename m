Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135639AbRDXOSi>; Tue, 24 Apr 2001 10:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135650AbRDXOS2>; Tue, 24 Apr 2001 10:18:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20492 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135639AbRDXOSX>; Tue, 24 Apr 2001 10:18:23 -0400
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 24 Apr 2001 15:18:11 +0100 (BST)
Cc: mhaque@haque.net (Mohammad A. Haque), ttel5535@artax.karlin.mff.cuni.cz,
        mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0104240939120.6992-100000@weyl.math.psu.edu> from "Alexander Viro" at Apr 24, 2001 09:40:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s3du-00029R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 24 Apr 2001, Mohammad A. Haque wrote:
> > Correct. <1024 requires root to bind to the port.
> ... And nothing says that it should be done by daemon itself.

Or that you shouldnt let inetd do it for you
And that you shouldn't drop the capabilities except that bind

It is possible to implement the entire mail system without anything running
as root but xinetd.




