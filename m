Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTFZXey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTFZXey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 19:34:54 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:55490 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S262984AbTFZXex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 19:34:53 -0400
Date: Thu, 26 Jun 2003 16:48:17 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Timothy Miller <miller@techsource.com>
cc: Oleg Drokin <green@namesys.com>, joe briggs <jbriggs@briggsmedia.com>,
       Edward Tandi <ed@efix.biz>, <reiser@namesys.com>,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AMD MP, SMP, Tyan 2466, REISERFS I/O error
In-Reply-To: <3EFB7E90.1090902@techsource.com>
Message-ID: <Pine.LNX.4.44.0306261642340.26045-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003, Timothy Miller wrote:
> 
> The PCI spec doesn't allow more than four slots per bus.  Some boards 
> try to put on 5 or 6 slots anyhow, violating the spec.  It's no wonder 
> there are so many problems with those boards.

the amd 760mpx chipset has two pci buses...

One, the Primary PCI 2.2 compliant 66-MHz/64-bit/32-bit PCI Bus is 
connected to the amd 762 north bridge, the Secondary PCI 2.2 compliant 
33-MHz/32-bit PCI Bus is connected to the amd 768 south bridge.

you won't find an mpx with more than 4 32 bit pci slots.

> You can often get them to work anyhow, but it involves swapping cards 
> around in slots until you find an arrangement that works, but it's still 
> unreliable.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


