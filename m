Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291214AbSBLWNV>; Tue, 12 Feb 2002 17:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291216AbSBLWNL>; Tue, 12 Feb 2002 17:13:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291214AbSBLWM6>; Tue, 12 Feb 2002 17:12:58 -0500
Subject: Re: File BlockSize
To: riel@conectiva.com.br (Rik van Riel)
Date: Tue, 12 Feb 2002 22:25:48 +0000 (GMT)
Cc: wli@holomorphy.com (William Lee Irwin III),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0202121959260.12554-100000@imladris.surriel.com> from "Rik van Riel" at Feb 12, 2002 08:00:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16alMy-0003GH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This sounds like fairly severe memory fragmentation, which seems more
> > worrisome to me than blocksize constraints. Should I look into that?
> 
> Sorry for being dense, but I don't see why an 8 kB block would
> need to occupy 2 contiguous pages in ram.

Because all the kernel code knows that you can add a constant to the
base of a buffer to get anywhere in that block. Also the one buffer
per two page case isnt handled either


Alan
