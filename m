Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286308AbRLJRBr>; Mon, 10 Dec 2001 12:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286313AbRLJRB2>; Mon, 10 Dec 2001 12:01:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49673 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286311AbRLJRBV>; Mon, 10 Dec 2001 12:01:21 -0500
Subject: Re: Linux/Pro  -- clusters
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 10 Dec 2001 17:09:43 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112101136490.14238-100000@binet.math.psu.edu> from "Alexander Viro" at Dec 10, 2001 11:49:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DTvz-0002dr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's _way_ easier than trying to fix leaks and dangling pointers in
> the fuzzy code we'd get with your approach.  Just look at the fun
> Richard has with devfs right now.

And it means we can get proper refcounting. Which as the maintainer of
two block drivers that support dynamic volume create/destroy is remarkably
good news.

Alan
