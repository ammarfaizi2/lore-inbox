Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbTCGLqN>; Fri, 7 Mar 2003 06:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbTCGLqM>; Fri, 7 Mar 2003 06:46:12 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43689
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261549AbTCGLqL>; Fri, 7 Mar 2003 06:46:11 -0500
Subject: Re: 2.5.64-mm1: Badness in request_irq
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1047015055.1538.7.camel@ixodes.goop.org>
References: <20030306141859.19645.qmail@linuxmail.org>
	 <1047015055.1538.7.camel@ixodes.goop.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047042076.20794.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 13:01:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 05:30, Jeremy Fitzhardinge wrote:
> On Thu, 2003-03-06 at 06:18, Felipe Alfaro Solana wrote:
> > Hello,  
> >   
> > I have just installed and compiled 2.5.64-mm1 using gcc-3.2.2 and,
> > when booting the system, I have found the  
> > following error on the kernel ring:  

Known problem. Once the core IRQ code is fixed in one of the suitable
ways people have suggested I'll sort the IDE layer out to match

