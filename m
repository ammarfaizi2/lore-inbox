Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271740AbRHQW3H>; Fri, 17 Aug 2001 18:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271738AbRHQW2r>; Fri, 17 Aug 2001 18:28:47 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:49134 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S271736AbRHQW2q>; Fri, 17 Aug 2001 18:28:46 -0400
Date: Fri, 17 Aug 2001 23:28:11 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
cc: <andre.dahlqvist@telia.com>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 'make dep' produces lots of errors with this .config
In-Reply-To: <20010817.151525.59654778.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0108172324001.11292-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, David S. Miller wrote:

> This build error can be solved in a sparc specific way.
> In FACT we would even want this code on Sparc32 in certain
> configurations.

It was strictly to get it to compile, sir. I guess the real fix is to
implement architecture specific code in the sparc port that vt.c can call
independently of the underlying architecture, yes?

-- 
A pancake! I've photocopied a pancake!

http://www.tahallah.demon.co.uk

