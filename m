Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSJATYk>; Tue, 1 Oct 2002 15:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262211AbSJATYk>; Tue, 1 Oct 2002 15:24:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61196 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262207AbSJATYj>; Tue, 1 Oct 2002 15:24:39 -0400
Date: Tue, 1 Oct 2002 20:30:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Martin Diehl <lists@mdiehl.de>, linux-kernel@vger.kernel.org
Subject: Re: calling context when writing to tty_driver
Message-ID: <20021001203003.D5092@flint.arm.linux.org.uk>
References: <Pine.LNX.4.21.0210010523290.485-100000@notebook.diehl.home> <20021001183400.GA8959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021001183400.GA8959@kroah.com>; from greg@kroah.com on Tue, Oct 01, 2002 at 11:34:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 11:34:00AM -0700, Greg KH wrote:
> Making write() block for any amount of data would increase the
> complexity of the drivers.  What should probably be done is convert the
> usb-serial drivers to use the new serial core, but I don't have the time
> to do this work right now.  Any takers?

It needs some changes to the serial core first.  I'm in 2.5 catchup mode
at the moment, I've also got stuff outstanding for 2.4.19 at present, so
I've _no_ idea when I'll be able to do the necessary changes on my side.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

