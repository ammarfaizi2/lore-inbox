Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSHPKyV>; Fri, 16 Aug 2002 06:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSHPKyV>; Fri, 16 Aug 2002 06:54:21 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:1294 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318292AbSHPKyU>;
	Fri, 16 Aug 2002 06:54:20 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linux-ide.org>
Date: Fri, 16 Aug 2002 12:56:23 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Part 2: Re: 2.5.31 boot failure on pdc20267
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <22B231216B8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 02 at 3:23, Andre Hedrick wrote:
> Try reading the entire document first before commenting and showing why
> people should not believe you.
> 
> The author went through great lengths to explain and capture what
> SFF-8038i defined.  The object is to show the difference.
> 
> Now carefully look and see that BAR4 in d1510 is not the same as 
> BAR 4 for SFF-8038i.

Chapter 5 describes IDE class devices, PCI class 0101. If this chapter 
is not normative definition, then it should be clearly stated in the
document, besides that it has no bussiness being there if it is just
for comparsion - just replace whole chapter with reference to the SFF-8038i.

Chapter 3, ATA Host Adapters, and also document name, ATA Host Adapters
Standards, makes strong impression to me that document is normative
for all host adapters. If you'll write chapter 5 in same style
chapter 4 is written (few lines, no registers description), and you'll
change document name, nobody will use it as normative document for
non-ADMA devices. But with current wording it is just normative
document for both PCI IDE DMA and ADMA hosts, even if T13 intentions
were different - document language matters, not intentions.

And amendment you pointed me to strongly signals that also Intel
believe[sd] that document is (in future) normative for PCI IDE DMA host 
adapters, not only for ADMA ones.

I was also impression (from the T13 meeting notes in Feb 20-22 2001
(meetings/e01114r0.pdf, 12.6)) that d1510 is successor of SFF8038.
If it adopts PCI DMA, it should document it (as it does now). If
it obsolete this interface, it should not document it...
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz

