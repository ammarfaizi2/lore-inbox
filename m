Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313438AbSDLIIn>; Fri, 12 Apr 2002 04:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313442AbSDLIIn>; Fri, 12 Apr 2002 04:08:43 -0400
Received: from firewall.sfn.asso.fr ([193.49.43.1]:62625 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S313438AbSDLIIl>;
	Fri, 12 Apr 2002 04:08:41 -0400
Date: Fri, 12 Apr 2002 10:08:04 +0200
From: Samuel Maftoul <maftoul@esrf.fr>
To: Rowan Ingvar Wilson <rowan.ingvar.wilson@0800dial.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: /dev/zero
Message-ID: <20020412100804.A6605@pcmaftoul.esrf.fr>
In-Reply-To: <1018595942.2918.2.camel@ADMIN> <002c01c1e1f3$5bf7e600$c82d3c3e@m3v0u8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's just zeroes, so it allows you to test raw write speed on any
device:
dd if=/dev/zero of=/dev/hda to test your performances of hda ...
normally if I get it well, /dev/zero can't be you're bottleneck.
        Sam
On Fri, Apr 12, 2002 at 08:26:22AM +0100, Rowan Ingvar Wilson wrote:
> Just as a matter of interest myself...what is it's actual function? It
> is used during kernel debugging to supply an input?
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Frank Schaefer
> Sent: 12 April 2002 08:19
> To: linux-kernel@vger.kernel.org
> Subject: Re: /dev/zero
> 
> On Fri, 2002-04-12 at 08:46, blesson paul wrote:
> > Hi all
> >                I am newbie to linux kernel. What is the use of
> /dev/zero. 
> > Why it is created and how to use it
> > regards
> > Blesson Paul
> > 
> > 
> > 
> > _________________________________________________________________
> > Chat with friends online, try MSN Messenger: http://messenger.msn.com
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> Hi,
> 
> /dev/zero is a data source. It delivers zeroes ( maybe that's why this
> name ;-).
> 
> BTW: You are new to the linux kernel or new to linux / unix?
> 
> Regards
> Frank
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
