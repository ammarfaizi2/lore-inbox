Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292551AbSBPVoz>; Sat, 16 Feb 2002 16:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292553AbSBPVoo>; Sat, 16 Feb 2002 16:44:44 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:41422 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S292551AbSBPVoe>;
	Sat, 16 Feb 2002 16:44:34 -0500
Date: Sat, 16 Feb 2002 22:44:16 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Eric Gillespie <viking@flying-brick.caverock.net.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What? Clock Slowdown Again?
Message-ID: <20020216224416.A32624@fafner.intra.cogenit.fr>
In-Reply-To: <Pine.LNX.4.21.0108201013170.4109-100000@brick.flying-brick.caverock.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0108201013170.4109-100000@brick.flying-brick.caverock.net.nz>; from viking@flying-brick.caverock.net.nz on Sat, Feb 16, 2002 at 09:51:02PM +1300
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Gillespie <viking@flying-brick.caverock.net.nz> :
[...]
> Also, what are the plans for replacing the virt_to_bus / bus_to_virt
> functions?  The sourcecode basically says to use pci_map functions, but, being
> almost a kernel illiterate (I know how to compile, apply patches, and not much
> else) I don't know how to get started on converting.  I thought that
> pci_resource_{start,end,len} may also be needed too.  Am I right?

Look at Documentation/DMA-mapping.txt, section "Types of DMA mappings"
Read it again from the start. If you aren't familiar with PCI, 
http://ww.google.com/search?hl=en&q=PCI+dual+address+cycle+explanation may
help. Then look at drivers/net/{epic/eepro100/3c59x}.c and grep for the
functions quoted in DMA-mapping.txt. After that, glue all the pieces in 
your head. 

-- 
Ueimor
