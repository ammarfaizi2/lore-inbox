Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSHTSeJ>; Tue, 20 Aug 2002 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSHTSeJ>; Tue, 20 Aug 2002 14:34:09 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:8722 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317107AbSHTSeF>;
	Tue, 20 Aug 2002 14:34:05 -0400
Date: Tue, 20 Aug 2002 11:32:53 -0700
From: Greg KH <greg@kroah.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
Message-ID: <20020820183253.GB29228@kroah.com>
References: <Pine.LNX.4.44.0208191111100.1048-100000@cherise.pdx.osdl.net> <3D6113E1.302@netscape.net> <20020819195909.GA24488@kroah.com> <3D61691B.7080409@netscape.net> <20020820033254.GA26331@kroah.com> <20020820065159.GD28996@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820065159.GD28996@pegasys.ws>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 23 Jul 2002 16:07:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 11:51:59PM -0700, jw schultz wrote:
> On Mon, Aug 19, 2002 at 08:32:55PM -0700, Greg KH wrote:
> > On Mon, Aug 19, 2002 at 09:54:35PM +0000, Adam Belay wrote:
> > > By the way, is diethotplug a space efficient binary version of the
> > > hotplug scripts or is there more to it then that?
> > 
> > Yes it is a space efficient version (the resulting binary is usually
> > 300% smaller than the original modules.*map files being used.)  It
> > achieves these space savings at the expense of flexibility, the binary
> > is always tied to a specific kernel version.
> 
> My apologies if you meant 30%

Very sorry, I ment that the original modules.*map files are 300% larger
than the diethotplug binary.

Hm, for the options I use in 2.5.31 I get these results:
  modules.pcimap	  6273 bytes
  modules.usbmap	 98513 bytes
  modules.ieee1394map	    73 bytes
  ----------------------------------
  total			104859 bytes

  diethotplug binary	 16332 bytes

Looks like the modules.*map files are closer to 650% larger :)

thanks,

greg k-h
