Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267358AbSKPUuk>; Sat, 16 Nov 2002 15:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267360AbSKPUuk>; Sat, 16 Nov 2002 15:50:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51473 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267358AbSKPUui>;
	Sat, 16 Nov 2002 15:50:38 -0500
Message-ID: <3DD6B120.7030906@pobox.com>
Date: Sat, 16 Nov 2002 15:57:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mzyngier@freesurf.fr
CC: Andries.Brouwer@cwi.nl, aebr@win.tue.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [PATCH] sysfs stuff for eisa bus [1/3]
References: <UTC200211161343.gAGDhQI15309.aeb@smtp.cwi.nl> <wrp8yztedb0.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <UTC200211161343.gAGDhQI15309.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier wrote:

> >>>>>"AB" == Andries Brouwer  writes:
> AB>     From: Alan Cox
> AB>     I think a ".ids" file list is valuable. It can be used for 
> things like
> AB>     EISA card identification obviously but it also has a big value for
> AB>     "lseisa" "lspnp" and friends (and hopefully when someone fixes the
> AB>     device model "lsdev").
>
> AB> Yes, lists are fine, but not in the kernel source.
>
> Ok, I'll remove it, and will put it somewhere else.


Unfortunately, I respectfully disagree with Andries.  Until 
drivers/pci/pci.ids list is removed from the kernel source, I think we 
are best served by modelling EISA on PCI as much as is reasonable.

> Does someone have something to say about the code itself, specially
> about the hacked drivers ? I haven't heard anything about it yet...


Well, I'm in favor of the patch.  Did Alan Cox have any special 
comments?  There isn't any special reason for the following, but I just 
have a general feeling that a thumbs up/thumbs down from him would be 
nice.  Alan?  Matthew Wilcox might be another good opinion to ping, 
because IIRC he occasionally runs into EISA in his rumblings too...

	Jeff, who would also like to see "sysfs stuff for MCA" too :)



