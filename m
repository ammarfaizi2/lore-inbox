Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbUDBSOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 13:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbUDBSO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 13:14:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:34227 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264114AbUDBSO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 13:14:28 -0500
Date: Fri, 2 Apr 2004 10:14:16 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
Message-ID: <20040402181416.GA30837@kroah.com>
References: <406D65FE.9090001@broadnet-mediascape.de> <6uad1uv7kr.fsf@zork.zork.net> <20040402144216.A12306@flint.arm.linux.org.uk> <20040402165941.GA29046@kroah.com> <20040402181630.B12306@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402181630.B12306@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 06:16:30PM +0100, Russell King wrote:
> On Fri, Apr 02, 2004 at 08:59:41AM -0800, Greg KH wrote:
> > No, this is the way it used to be, and it caused all kinds of problems
> > in the past.  It was switched to use 'select' on purpose, and should
> > stay that way.
> 
> It's causing problems today by preventing people from being able to
> de-select SCSI for no obvious reason.

Ok, you get people complaining either way.  So no matter what people
aren't happy :(

As Linus is the one who enabled this option for CONFIG_USB_STORAGE, I'm
going to rule that it should stay the way it currently is.

thanks,

greg k-h
