Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSEZLIb>; Sun, 26 May 2002 07:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSEZLIb>; Sun, 26 May 2002 07:08:31 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:30901 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315941AbSEZLI3>;
	Sun, 26 May 2002 07:08:29 -0400
Date: Sun, 26 May 2002 13:08:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
Message-ID: <20020526130822.B16548@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10205242204360.31297-100000@master.linux-ide.org> <Pine.LNX.4.10.10205260242450.3010-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 02:50:25AM -0700, Andre Hedrick wrote:

> Look another pair of Copyrights deleted.
> I wonder how many other people besides myself have had their copyright
> deleted, too?  Did you you do it to the AMD driver too?
> I made a mistake in the past when I offered you the option to maintain the
> via82cxxx.c chipset.  IIRC, you deleted 4 Copyrights then.
> 
> Oh well ...

Please check out the definition of 'derivative work'.
Also check how much the old driver is similar to the new one
and if that does constitute a derivative work as per the definition.
Thanks.

> Andre Hedrick
> LAD Storage Consulting Group
> 
> 
> --- linux-2.5.6-timing/drivers/ide/piix.c       Tue Mar 12 16:26:03 2002
> +++ linux-2.5.6-piix/drivers/ide/piix.c Tue Mar 12 20:35:40 2002
> @@ -1,499 +1,510 @@
>  /*
> - *  linux/drivers/ide/piix.c           Version 0.32    June 9, 2000
> + * $Id: piix.c,v 1.1 2002/10/10 22:58:60 vojtech Exp $
>   *
> - *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
> - *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
> - *  May be copied or modified under the terms of the GNU General Public License
> + *  Copyright (c) 2000-2002 Vojtech Pavlik
>   *
> 
> 
> 
> On Fri, 24 May 2002, Andre Hedrick wrote:
> 
> > 
> > Where do you get off delete copyrights?
> > GPL permits changing it does not give you the right to steal, lie, cheat,
> > defraud, other peoples work.  However I should not expect anything of
> > honor from a person of your high morals.  I know you want to rewrite the
> > past to make it so I and other never existed, but you are pathetic.
> > 
> > On Fri, 24 May 2002, Vojtech Pavlik wrote:
> > 
> > > On Fri, May 24, 2002 at 04:29:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > Hi!
> > > > 
> > > > I have a very quick look over patch/driver... looks quite ok...
> > > > 
> > > > But it doesn't support multiple controllers. We should add 'unsigned
> > > > long private' to 'ata_channel struct' and store index in the chipset
> > > > table there.
> > > > You can remove duplicate entries from module data table.
> > > > 
> > > > BTW: please don't touch pdc202xx.c I am playing with it...
> > > 
> > > Here is a new patch. Martin: This one should be OK for inclusion now.
> > > Bartlomiej: Please check it anyway.
> > > 
> > > -- 
> > > Vojtech Pavlik
> > > SuSE Labs
> > > 
> > 
> > Andre Hedrick
> > LAD Storage Consulting Group
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 

-- 
Vojtech Pavlik
SuSE Labs
