Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277145AbRJHVYt>; Mon, 8 Oct 2001 17:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277141AbRJHVYj>; Mon, 8 Oct 2001 17:24:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29714 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277138AbRJHVYa>; Mon, 8 Oct 2001 17:24:30 -0400
Subject: Re: write/read cache raid5
To: raid@ddx.a2000.nu
Date: Mon, 8 Oct 2001 22:29:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0110082309400.28345-100000@ddx.a2000.nu> from "raid@ddx.a2000.nu" at Oct 08, 2001 11:10:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qhyE-0001ws-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > protected, battery backed, ECC'd etc. That is one place where things like
> > the DPT (now Adaptec) millenium hardware raid can do a lot better than
> > software solutions
> 
> So there is no way i can Speedup write to the raid5 array ?
> (memory will be ecc and the server will be on ups)

And you have no ECC on the PCI bus, nor will a UPS protect against a crash.

