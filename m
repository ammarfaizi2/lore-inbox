Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSKJXuX>; Sun, 10 Nov 2002 18:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265259AbSKJXuX>; Sun, 10 Nov 2002 18:50:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61967 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265008AbSKJXuW>;
	Sun, 10 Nov 2002 18:50:22 -0500
Message-ID: <3DCEF234.8060000@pobox.com>
Date: Sun, 10 Nov 2002 18:56:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs stuff for eisa bus [1/3]
References: <wrpbs4xgke4.fsf@hina.wild-wind.fr.eu.org> <20021110233206.GA3988@win.tue.nl>
In-Reply-To: <wrpbs4xgke4.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

> On Sun, Nov 10, 2002 at 10:55:15PM +0100, Marc Zyngier wrote:
>
>
> >First patch is contains the infrastructure and the naming database :
>
>
> Is the database not very incomplete?
> What use is a very long and very incomplete list?
> Just like for USB and PCI it might be more reasonable to
> have such a list with IDs on a website instead of in the
> kernel source?



While I do agree your criticisms are fair, I think they apply to the 
overall system and not specifically to Marc's EISA code.  I've been 
hoping that someone would do the infrastructure work necessary to 
support drivers in a pci_driver-like fashion, and I'm glad Marc has done 
this.

That said, tangent to your argument, I would also like to separate the 
PCI ids from the C source code -- but still compile the PCI id table 
into the .o file by default.  There are certainly other uses for the PCI 
id table, but I think sufficient additional flexibility is afforded 
simply by the movement of the id table at source code level.

	Jeff


