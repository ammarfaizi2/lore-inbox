Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTJDVkI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTJDVkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 17:40:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:1229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262772AbTJDVkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 17:40:05 -0400
Date: Sat, 4 Oct 2003 14:39:46 -0700
From: Greg KH <greg@kroah.com>
To: Juan Carlos Castro Y Castro <jcastro@dba.com.br>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel doesn't see USB ADSL modem - pegasus?
Message-ID: <20031004213945.GB8566@kroah.com>
References: <A36146B96FA84B4BB69EB088451E965A080CE792@cygnus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A36146B96FA84B4BB69EB088451E965A080CE792@cygnus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 02:10:57AM -0300, Juan Carlos Castro Y Castro wrote:
> (Please CC me here and at jcastro@vialink.com.br -- I'm not subscribed)
> 
> I have a SpeedStream 5200 ADSL modem, connected to the USB port. From what I
> understand, the pegasus driver should see it. I installed 2.4.23-pre6,
> modprobe'd usbnet and pegasus, but no new interface shows up. (I tested with
> ip link show)
> 
> Maybe I should patch the driver to include a device ID or something of the
> sort?

Try that, the driver currently does not support this device id.  Let us
know how that works.

thanks,

greg k-h
