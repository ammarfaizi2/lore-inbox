Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTEEQqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTEEQqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:46:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:34703 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263737AbTEEQoa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:44:30 -0400
Date: Mon, 5 May 2003 09:58:48 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
Message-ID: <20030505165848.GA1249@kroah.com>
References: <20030427115644.GA492@zip.com.au> <20030428205522.GA26160@kroah.com> <20030505083458.GA621@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505083458.GA621@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 06:34:58PM +1000, CaT wrote:
> On Mon, Apr 28, 2003 at 01:55:22PM -0700, Greg KH wrote:
> > On Sun, Apr 27, 2003 at 09:56:44PM +1000, CaT wrote:
> > > I keep a-lookin but I can't find any data. Have I missed something?
> > > 
> > > # find | grep -i pii
> > > ./bus/pci/drivers/piix4 smbus
> > > ./bus/pci/drivers/piix4 smbus/00:07.3
> > > ./bus/pci/drivers/PIIX IDE
> > > ./bus/pci/drivers/PIIX IDE/00:07.1
> > > # find | grep -i i2c
> > > ./bus/i2c
> > > ./bus/i2c/drivers
> > > ./bus/i2c/drivers/lm75
> > > ./bus/i2c/drivers/IT87xx
> > > ./bus/i2c/drivers/dev driver
> > > ./bus/i2c/devices
> > 
> > No devices?  Does 2.5.68 work for you?
> 
> Does not look like it:

Ok, but 2.5.67 worked for you, right?  Care to do a binary search
through the different -bk trees inbetween to find where it stopped
working for you?

thanks,

greg k-h
