Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSE0JlQ>; Mon, 27 May 2002 05:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316540AbSE0JlP>; Mon, 27 May 2002 05:41:15 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37578 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316538AbSE0JlO>;
	Mon, 27 May 2002 05:41:14 -0400
Date: Mon, 27 May 2002 11:40:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Trivial: move PCI ID definitions from ide-pci.c to pci_ids.h
Message-ID: <20020527114054.C26574@ucw.cz>
In-Reply-To: <20020526152204.A18812@ucw.cz> <3CF1E7C0.9090909@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 10:01:04AM +0200, Martin Dalecki wrote:

> > diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > --- a/include/linux/pci_ids.h	Sun May 26 15:20:16 2002
> > +++ b/include/linux/pci_ids.h	Sun May 26 15:20:16 2002
> > @@ -1787,3 +1787,7 @@
> >  #define PCI_DEVICE_ID_MICROGATE_USC	0x0010
> >  #define PCI_DEVICE_ID_MICROGATE_SCC	0x0020
> >  #define PCI_DEVICE_ID_MICROGATE_SCA	0x0030
> > +
> > +#define PCI_VENDOR_ID_HINT		0x3388
> > +#define PCI_DEVICE_ID_HINT_VXPROII_IDE	0x8013
> > +
> 
> Please note that pci_ids.h. is a generated file. The ids have to be
> moved to the ancestor of it as well.

Generated? I don't think so. devlist.h is, same for classlist.h, but not
pci_ids.h

-- 
Vojtech Pavlik
SuSE Labs
