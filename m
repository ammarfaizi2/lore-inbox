Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSHUDgY>; Tue, 20 Aug 2002 23:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSHUDgY>; Tue, 20 Aug 2002 23:36:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15622
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317694AbSHUDgY>; Tue, 20 Aug 2002 23:36:24 -0400
Date: Tue, 20 Aug 2002 20:40:05 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac5 Promise PDC20269
In-Reply-To: <20020821031509.GA11920@codepoet.org>
Message-ID: <Pine.LNX.4.10.10208202039520.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fair arguement.

On Tue, 20 Aug 2002, Erik Andersen wrote:

> On Tue Aug 20, 2002 at 07:40:37PM -0700, Andre Hedrick wrote:
> > > hde reduced to Ultra33 mode.
> > > hde: host protected area => 1
> > > hde: 117266688 sectors (60041 MB) w/1820KiB Cache, CHS=116336/16/63, UDMA(133)
> 
> BTW that host protected area message is pretty silly. It gives
> the appearance that perhaps the BIOS has issued a SET MAX ADDRESS
> when in fact, all the message is doing is enumerating the drive's
> capabilities (duplicating what 'hdparm -I' does).  At the
> minimum, this message should be changed to something more like:
> 
>     printk("%s: host protected area supported: %s\n", 
> 	    drive->name, (flag==1)? "no" : "yes");
> 
> Personally, I think we should lose the message entirely.  If
> someone want to know what their drive can do, they can ask
> hdparm and get a full listing,
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> 

Andre Hedrick
LAD Storage Consulting Group

