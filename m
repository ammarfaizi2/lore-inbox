Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315937AbSEZLGS>; Sun, 26 May 2002 07:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSEZLGR>; Sun, 26 May 2002 07:06:17 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:27829 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315937AbSEZLGR>;
	Sun, 26 May 2002 07:06:17 -0400
Date: Sun, 26 May 2002 13:05:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
Message-ID: <20020526130547.A16548@ucw.cz>
In-Reply-To: <20020524172910.A17984@ucw.cz> <Pine.LNX.4.10.10205242204360.31297-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 10:07:36PM -0700, Andre Hedrick wrote:
> 
> Where do you get off delete copyrights?
> GPL permits changing it does not give you the right to steal, lie, cheat,
> defraud, other peoples work.  However I should not expect anything of
> honor from a person of your high morals.  I know you want to rewrite the
> past to make it so I and other never existed, but you are pathetic.

I don't delete copyrights, where applicable. However, in this case, none
of the original code stayed, not a single line - I first wrote a spec
based on the old driver and then wrote a new driver from scratch based
on that spec. So, you really don't have a copyright on the new Artop
driver, sorry.

> On Fri, 24 May 2002, Vojtech Pavlik wrote:
> 
> > On Fri, May 24, 2002 at 04:29:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Hi!
> > > 
> > > I have a very quick look over patch/driver... looks quite ok...
> > > 
> > > But it doesn't support multiple controllers. We should add 'unsigned
> > > long private' to 'ata_channel struct' and store index in the chipset
> > > table there.
> > > You can remove duplicate entries from module data table.
> > > 
> > > BTW: please don't touch pdc202xx.c I am playing with it...
> > 
> > Here is a new patch. Martin: This one should be OK for inclusion now.
> > Bartlomiej: Please check it anyway.
> > 
> > -- 
> > Vojtech Pavlik
> > SuSE Labs
> > 
> 
> Andre Hedrick
> LAD Storage Consulting Group

-- 
Vojtech Pavlik
SuSE Labs
