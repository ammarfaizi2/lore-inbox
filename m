Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVLUOZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVLUOZP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 09:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVLUOZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 09:25:14 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:6671 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932430AbVLUOZN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 09:25:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <17321.25650.271585.790597@gargle.gargle.HOWL>
X-OriginalArrivalTime: 21 Dec 2005 14:25:12.0080 (UTC) FILETIME=[5A60C900:01C6063A]
Content-class: urn:content-classes:message
Subject: Re: About 4k kernel stack size....
Date: Wed, 21 Dec 2005 09:25:11 -0500
Message-ID: <Pine.LNX.4.61.0512210923580.11743@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: About 4k kernel stack size....
Thread-Index: AcYGOlpoEAbcZnChRzuW8m9/GA/d5g==
References: <20051218231401.6ded8de2@werewolf.auna.net><43A77205.2040306@rtr.ca><20051220133729.GC6789@stusta.de><170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com><46578.10.10.10.28.1135094132.squirrel@linux1><Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com><17320.35736.89250.390950@gargle.gargle.HOWL><Pine.LNX.4.61.0512210901340.11568@chaos.analogic.com> <17321.25650.271585.790597@gargle.gargle.HOWL>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nikita Danilov" <nikita@clusterfs.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2005, Nikita Danilov wrote:

> linux-os (Dick Johnson) writes:
> >
> > On Tue, 20 Dec 2005, Nikita Danilov wrote:
> >
> > > linux-os \(Dick Johnson\) writes:
> > > >
> > >
> > > [...]
> > >
> > > > See, isn't rule-making fun? This whole 4k stack-
> > > > thing is really dumb. Other operating systems
> > > > use paged virtual memory for stacks, except
> > > > for the interrupt stack. If Linux used paged
> > > > virtual memory for stacks,
> > >
> > > ... then spin-locks couldn't be held across function calls.
> > >
> >
> > Sure they can! In ix86 machines the local 'cli' within the
>
> Sure they cannot: one cannot schedule with spin-lock held, and major
> page fault will block for IO.
>
> [...]
>

Read the text you deleted and you will learn how.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
