Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992678AbWJTVFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992678AbWJTVFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946512AbWJTVFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:05:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3592 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946514AbWJTVFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:05:36 -0400
Date: Fri, 20 Oct 2006 23:05:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Alan Cox <alan@redhat.com>,
       Patrick Jefferson <henj@hp.com>, Kenny Graunke <kenny@whitecape.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [2.6.19 patch] drivers/ide/pci/generic.c: re-add the __setup("all-generic-ide",...)
Message-ID: <20061020210533.GW3502@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061017155934.GC3502@stusta.de> <4534C7A7.7000607@hp.com> <20061018221520.GK3502@stusta.de> <20061018231844.GA16857@devserv.devel.redhat.com> <20061019152651.GR3502@stusta.de> <20061019090741.853ea100.randy.dunlap@oracle.com> <20061019161338.GT3502@stusta.de> <1161275398.17335.87.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161275398.17335.87.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 05:29:58PM +0100, Alan Cox wrote:
> Ar Iau, 2006-10-19 am 18:13 +0200, ysgrifennodd Adrian Bunk:
> > > Missing update to Documentation/kernel-parameters.txt ?
> > > (maybe it's been missing forever?)
> > 
> > It's been missing forever.
> > 
> > I'm not sure whether documenting it now where it's deprecated and nearly 
> > dead makes sense..
> 
> Its not dead, its so useful that drivers/ata also supports it

But in the drivers/ata case it's a module parameter, not a __setup 
kernel parameter.

And I don't think it makes sense to manually add module parameters to 
kernel-parameters.txt

If a documentation of all module parameters is considered useful, 
someone should write a script to automatically generate such a list.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

