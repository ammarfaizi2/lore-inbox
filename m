Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbSJVLxa>; Tue, 22 Oct 2002 07:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSJVLx3>; Tue, 22 Oct 2002 07:53:29 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62136 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262476AbSJVLx0>; Tue, 22 Oct 2002 07:53:26 -0400
Subject: Re: PROBLEM: PCMCIA cardmgr kill hangs kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Take Vos <Take.Vos@binary-magic.com>
Cc: bert hubert <ahu@ds9a.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210221313.49423.Take.Vos@binary-magic.com>
References: <200210221046.46700.Take.Vos@binary-magic.com>
	<20021022093410.GA2392@outpost.ds9a.nl> 
	<200210221313.49423.Take.Vos@binary-magic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 13:15:39 +0100
Message-Id: <1035288939.31917.57.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 12:13, Take Vos wrote:
> removing the flashcard from the pcmcia slot also hangs the kernel.
> So it seams a flashcard issue (I had issues with this card in the early 2.4.x 
> kernels, but it would hang the kernel at insertion)

IDE card eject was broken in the new IDE code but should have been
fixed, unless it has come broken again. I'll investigate at some point
soon

