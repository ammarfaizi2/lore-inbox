Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbTICTsR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTICTrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:47:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:37042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264116AbTICTpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:45:22 -0400
Date: Wed, 3 Sep 2003 12:36:34 -0700
From: Greg KH <greg@kroah.com>
To: watermodem <aquamodem@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4
Message-ID: <20030903193634.GA1982@kroah.com>
References: <3F560DC6.2090709@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F560DC6.2090709@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 10:50:30AM -0500, watermodem wrote:
> 
> 4) Problems include:
>    The USB and CUPs problem that I see the USB tree under 
> "/sys/bus/usb" where-as under /proc/bus/usb I see nothing.
> This may break a lot of existing code such as CUPS Is is suppose to be 
> this way? This means USB printer is not seen by the environment but seen 
> on boot.

For why nothing is showing up in /proc/bus/usb and how to fix that,
please see the Linux USB FAQ at http://www.linux-usb.org/

In short, they are two different things, and we have not removed the
info that was in /proc/bus/usb/*  (with the exception of the drivers
file in there, but no one was using that...)

thanks,

greg k-h
