Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312392AbSDSRaO>; Fri, 19 Apr 2002 13:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSDSRaN>; Fri, 19 Apr 2002 13:30:13 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:2055 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312392AbSDSRaM>;
	Fri, 19 Apr 2002 13:30:12 -0400
Date: Fri, 19 Apr 2002 09:28:56 -0700
From: Greg KH <greg@kroah.com>
To: mtopper@xarch.tu-graz.ac.at
Cc: support@suse.de,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: USB-Mouse-Bug in 2.4.16-8 ?
Message-ID: <20020419162856.GD13046@kroah.com>
In-Reply-To: <20020416102501.GG17043@suse.de> <Pine.LNX.4.21.0204161234520.5014-100000@xarch.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 22 Mar 2002 14:08:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 12:39:07PM +0200, mtopper@xarch.tu-graz.ac.at wrote:
> 
> Dear Mailing List, 
> 
> I've discovered that even if I insmod (or modprobe) the proper USB modules
> for my 2.4.16 kernel, and if I use the USB mouse afterwards,
> "lsmod" reveals that the modules seem to be "(0) unused" - despite the USB
> mouse is in action!
> 
> Users of the 2.4.18-kernel affirmed same kernel behaviour.
> 
> If I rmmod the USB modules, they subsequently allow to be removed from
> kernelspace, and the USB mouse cursor , ofcourse , stops instantly -
> despite he was just in use. 
> 
> Is this a bug or a feature? :-)

This is the way the module was designed, so yes it's a feature :)

thanks,

greg k-h
