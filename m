Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbRATU5F>; Sat, 20 Jan 2001 15:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132374AbRATU47>; Sat, 20 Jan 2001 15:56:59 -0500
Received: from styx.suse.cz ([195.70.145.226]:15088 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129933AbRATU4q>;
	Sat, 20 Jan 2001 15:56:46 -0500
Date: Sat, 20 Jan 2001 21:56:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Message-ID: <20010120215641.A1818@suse.cz>
In-Reply-To: <ejgj6tg2l03r18grn4shgtjmsp5cip6qc9@4ax.com> <Pine.LNX.4.10.11101200938180.2302-100000@master.linux-ide.org> <qtmj6ts01faanviv5l6rgi4cnseugs8lg7@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <qtmj6ts01faanviv5l6rgi4cnseugs8lg7@4ax.com>; from alan@chandlerfamily.org.uk on Sat, Jan 20, 2001 at 06:45:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 06:45:10PM +0000, Alan Chandler wrote:
> On Thu, 20 Jan 2011 09:51:03 -0800 (PST), you wrote:
> 
> >On Sat, 20 Jan 2001, Alan Chandler wrote:
> >
> >> I'm running with an Abit K7 (uses via82c686a in southbridge) with IBM
> >> deskstar 8.4gb disks (DHEA-38451) as masters in ide0 and 1. They only
> >> do UDMA mode 2. I am not overclocking or anything - all should be
> >> running at default speeds with an Athlon 900.  
> >> 
> >> Just to be clear - I am NOT getting any errors when I switch back to
> >> the 2.2.17 kernel (debian standard) - with a 2.4.0 kernel they occur
> >> every few minutes when there is significant disk activity. 
> >
> >But that kernel uses the stock driver that was the original second
> >generation correct?
> >
> >Andre Hedrick
> >Linux ATA Development
> >
> 
> Sorry, I realise now what I said was ambiguous.  To be clear
> 
> 2.2.17 - absolutely standard as shipped in debian - no errors
> 2.4.0 - standard (downloaded tar.bz2) - ERRORS
> 2.4.0 - as standard except for three files in tar.bz2 attachment to
> Vojtech Pavlik's mail which were placed in drivers/ide directory -
> ERRORS. 
> Alan

Wonderful! A case where I can compare a working setup with a nonworking
one! :) Could you please send me the usual stuff (dmesg, lspci -vvxxx,
cat /proc/ide/via, hdparm -i /dev/hd*, hdparm -t /dev/hd*) for both the
2.2 case and the 2.4.0+VIA-latest case? That'll allow me to find the
differences and possibly fix the new driver.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
