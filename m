Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTJGSZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJGSZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:25:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:61571 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262672AbTJGSZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:25:38 -0400
Date: Tue, 7 Oct 2003 11:08:52 -0700
From: Greg KH <greg@kroah.com>
To: Juan Carlos Castro y Castro <jcastro@vialink.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel doesn't see USB ADSL modem - pegasus?
Message-ID: <20031007180851.GH1956@kroah.com>
References: <3F7F7A9E.1060204@vialink.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7F7A9E.1060204@vialink.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 10:57:50PM -0300, Juan Carlos Castro y Castro wrote:
> Well, it didn't work -- I inserted the following line in pegasus.h:
> 
> PEGASUS_DEV( "SpeedStream", VENDOR_SIEMENS, 0xe240,
> DEFAULT_GPIO_RESET | PEGASUS_II )
> 
> Because that's what appeared in /proc/bus/usb/devices. But now, modprobe 
> pegasus hangs (the process, not the machine). Also, any attemp to access 
> /proc/bus/usb hangs the process. Kudzu hangs too. Now I reached the 
> limits of my knowledge. :(

Sorry, this device is probably not supported by that driver :(

Can you return it and get something else?

Good luck,

greg k-h
