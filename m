Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318334AbSHPLMB>; Fri, 16 Aug 2002 07:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318333AbSHPLMB>; Fri, 16 Aug 2002 07:12:01 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30736
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318334AbSHPLL7>; Fri, 16 Aug 2002 07:11:59 -0400
Date: Fri, 16 Aug 2002 04:05:57 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: Part 2: Re: 2.5.31 boot failure on pdc20267
In-Reply-To: <22B231216B8@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208160357360.12468-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr,

I know exactly what the document started out as and the intentions and the
transformations to what it is now.

The intent was to describe a new HOST protocol.
Something like FP-DMA which is similar to what SBP-2 maps.

Now the document I pointed to as an ammendment had a pre-release only
handed out in paper.  There are no e-copies, and it was the intent of the
second author to preserve the original definition and terms used by 8038i.

Next T13 has no business defining HOST standards it is DISK committee.
Go fish :-/

Now if the lastest evolution of the d1510 has an error well it needs to be
fixed.  Since I know what it is to do and how it does and the intent, I do
not used them for references.

But for the record you are required to have the EOT set if you are using
8038i protocols.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 16 Aug 2002, Petr Vandrovec wrote:

> On 16 Aug 02 at 3:23, Andre Hedrick wrote:
> > Try reading the entire document first before commenting and showing why
> > people should not believe you.
> > 
> > The author went through great lengths to explain and capture what
> > SFF-8038i defined.  The object is to show the difference.
> > 
> > Now carefully look and see that BAR4 in d1510 is not the same as 
> > BAR 4 for SFF-8038i.
> 
> Chapter 5 describes IDE class devices, PCI class 0101. If this chapter 
> is not normative definition, then it should be clearly stated in the
> document, besides that it has no bussiness being there if it is just
> for comparsion - just replace whole chapter with reference to the SFF-8038i.
> 
> Chapter 3, ATA Host Adapters, and also document name, ATA Host Adapters
> Standards, makes strong impression to me that document is normative
> for all host adapters. If you'll write chapter 5 in same style
> chapter 4 is written (few lines, no registers description), and you'll
> change document name, nobody will use it as normative document for
> non-ADMA devices. But with current wording it is just normative
> document for both PCI IDE DMA and ADMA hosts, even if T13 intentions
> were different - document language matters, not intentions.
> 
> And amendment you pointed me to strongly signals that also Intel
> believe[sd] that document is (in future) normative for PCI IDE DMA host 
> adapters, not only for ADMA ones.
> 
> I was also impression (from the T13 meeting notes in Feb 20-22 2001
> (meetings/e01114r0.pdf, 12.6)) that d1510 is successor of SFF8038.
> If it adopts PCI DMA, it should document it (as it does now). If
> it obsolete this interface, it should not document it...
>                                         Petr Vandrovec
>                                         vandrove@vc.cvut.cz
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

