Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312817AbSDSOsv>; Fri, 19 Apr 2002 10:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312826AbSDSOsu>; Fri, 19 Apr 2002 10:48:50 -0400
Received: from venus.ci.uw.edu.pl ([193.0.74.207]:49938 "EHLO
	venus.ci.uw.edu.pl") by vger.kernel.org with ESMTP
	id <S312817AbSDSOsu>; Fri, 19 Apr 2002 10:48:50 -0400
Date: Fri, 19 Apr 2002 16:43:15 +0200 (CEST)
From: Jan Slupski <jslupski@email.com>
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
In-Reply-To: <20020419164048.H15517@suse.de>
Message-ID: <Pine.LNX.4.21.0204191636290.8479-100000@venus.ci.uw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Dave Jones wrote:

> On Fri, Apr 19, 2002 at 04:02:18PM +0200, Jan Slupski wrote:
> 
>  > Only problem is I don't have DMI Product names for all involved models.
>  > That's why I left pretty general:
>  >   MATCH(DMI_PRODUCT_NAME, "PCG-")
> 
> Too generic. This matches my Z600 for example, which does not have this bug.

I know.
But it PCI id/vendor probably will not match.

But if you think, it's better to add all 12-15 models separately,
why not?
I can start asking for this information...

FX240 will have:
MATCH(DMI_PRODUCT_NAME, "PCG-FX240(UC)")
probably 
MATCH(DMI_PRODUCT_NAME, "PCG-FX240")
is enough.

Do you know any simple tool to retrieve DMI information?
I did it by enabling debug output in kernel, but it would be easier
if I haven't to ask everybody to do thi...

Jan

   _  _  _  _  _____________________________________________
   | |_| |\ |  S L U P S K I              jslupski@email.com
 |_| | | | \|                 http://www.pm.waw.pl/~jslupski  


