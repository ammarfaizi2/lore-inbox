Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268009AbTB1Qcd>; Fri, 28 Feb 2003 11:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268014AbTB1Qcd>; Fri, 28 Feb 2003 11:32:33 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20114
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268009AbTB1Qcc>; Fri, 28 Feb 2003 11:32:32 -0500
Subject: Re: Proposal: Eliminate GFP_DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: D.A.Fedorov@inp.nsk.su
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su>
References: <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046454339.17694.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 17:45:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 15:44, Dmitry A. Fedorov wrote:
> But why drivers of ISA bus devices with DMA should use pci_* functions?
> 
> I'm personally wouldn't have too much pain with GFP_DMA because I have
> compatibility headers and proposed change for them is tiny.

ISA devices or ISA like devices on non x86-32 platforms already need to
do this to work on non PC boxes. I'm hoping the generic DMA framework
stuff will make that all much cleaner for 2.7

