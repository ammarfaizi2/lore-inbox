Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277351AbRJELQ6>; Fri, 5 Oct 2001 07:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277352AbRJELQs>; Fri, 5 Oct 2001 07:16:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55044 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277351AbRJELQg>; Fri, 5 Oct 2001 07:16:36 -0400
Subject: Re: Development Setups
To: adam.keys@HOTARD.engr.smu.edu
Date: Fri, 5 Oct 2001 12:22:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there> from "Adam Keys" at Oct 04, 2001 11:20:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pT3g-00066g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was thinking of starting with a modern machine for developing/compiling on, 
> and then older machine(s) for testing.  This way I would not risk losing data 

That is how I work. One box editing/building and one testing. It also allows
you to stare at dumps, oopses and things as well as the source at the same
time.

> Instead of having separate machines,  there is the possibility of using the 
> Usermode port.  As I understand it this lags behind the -ac and linus kernels 
> so it would be hard to test things like the new VM's.  Usermode would not be 

Usermode Linux is merged with the -ac tree - it is great if you want to do
non device driver hardware work.
