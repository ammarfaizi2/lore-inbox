Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313906AbSERT0P>; Sat, 18 May 2002 15:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSERT0P>; Sat, 18 May 2002 15:26:15 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:56848 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S313867AbSERT0O>; Sat, 18 May 2002 15:26:14 -0400
Date: Sat, 18 May 2002 21:26:06 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: IO/MMIO 2.4 ATA/IDE driver recore near complete
Message-ID: <20020518212606.H635@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.10.10205180230290.774-100000@master.linux-ide.org> <20020517031515.20062@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 04:15:15AM +0100, Benjamin Herrenschmidt wrote:
> >Please note BMDMA for MMIO is not native since there appears to be
> >pci-posting errors under x86.
> 
> Can you elaborate ? I had to deal with driver bugs related to
> PCI wr. posting in the past. I assume you know what you are doing,
> but just in case, you missed a SW bug, I may be able to help.

I'm also interested in these issues, since I plan to use BMDMA
into MMIO areas in my own driver. So maybe we should discuss this
on the list? ;-)

Also the machines/chipsets, where this happens would be nice to
know. How to detect and workaround such errors is another
challenging topic I would like to discuss.

Thanks and Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
