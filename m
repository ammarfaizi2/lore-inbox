Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVBXT0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVBXT0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVBXT0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:26:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:5258 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262453AbVBXTZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:25:55 -0500
Date: Thu, 24 Feb 2005 11:22:07 -0800
From: Greg KH <greg@kroah.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224192207.GB12018@kroah.com>
References: <20050224175918.GA7627@mail.muni.cz> <20050224181347.GA10847@kroah.com> <20050224182300.GA7778@mail.muni.cz> <20050224184928.GA11490@kroah.com> <20050224190548.GA7978@mail.muni.cz> <20050224191243.GD11806@kroah.com> <20050224191809.GB7978@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224191809.GB7978@mail.muni.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 08:18:09PM +0100, Lukas Hejtmanek wrote:
> On Thu, Feb 24, 2005 at 11:12:43AM -0800, Greg KH wrote:
> > > When connected through uhci-hcd:
> > > T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> > 
> > Your device is only reporting that it can go at 12Mbit (full speed, not
> > 480Mbit, which is high speed.)
> 
> Is this independent of used driver?

Yes, this is read from the descriptor of the device.

thanks,

greg k-h
