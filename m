Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTF0Lth (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTF0Lth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:49:37 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:37760 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S264271AbTF0Lta convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:49:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Timothy Miller <miller@techsource.com>, Oleg Drokin <green@namesys.com>
Subject: Re: AMD MP, SMP, Tyan 2466, REISERFS I/O error
Date: Fri, 27 Jun 2003 09:01:47 -0400
User-Agent: KMail/1.4.3
Cc: Edward Tandi <ed@efix.biz>, reiser@namesys.com,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <BB1F47F5.17533%kernel@mousebusiness.com> <20030626115525.GA13194@namesys.com> <3EFB7E90.1090902@techsource.com>
In-Reply-To: <3EFB7E90.1090902@techsource.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306270901.47242.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In this specific case of the Tyan S2466, it has 2 64/66 slots, and 4 32/33 
slots.   The chipset is the AMD 760MPX, AMD 762 system controller, and AMD 
768 peripheral controller, and the Winbound 83627 super i/o asic.  

I thought that this chipset actually had 2 pci controllers - one for the 
64-bit slots and the other for the 32-bit.  Am I wrong?

On Thursday 26 June 2003 07:15 pm, Timothy Miller wrote:
> Oleg Drokin wrote:
> > Is not this is one of those heavy-PCI loaded boxes that ocasionally
> > corrupt data when PCI is overloaded?
> > The log you quoted shows that suddenly tree nodes have incorrect content
> > (and the i/o error is because reiserfs does not know what to do with such
> > nodes). (and we hope to push the patch that will print device where error
> > have occured soon).
>
> The PCI spec doesn't allow more than four slots per bus.  Some boards
> try to put on 5 or 6 slots anyhow, violating the spec.  It's no wonder
> there are so many problems with those boards.
>
> You can often get them to work anyhow, but it involves swapping cards
> around in slots until you find an arrangement that works, but it's still
> unreliable.

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
