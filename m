Return-Path: <linux-kernel-owner+w=401wt.eu-S1751171AbXANIF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbXANIF4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 03:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbXANIF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 03:05:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:40937 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbXANIFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 03:05:55 -0500
Date: Sun, 14 Jan 2007 00:03:27 -0800
From: Greg KH <greg@kroah.com>
To: ved@lenta.ru
Cc: linux-kernel@vger.kernel.org, Bernhard Kaindl <bk@suse.de>
Subject: Re: Kernel 2.6.19.2 PCI issue
Message-ID: <20070114080327.GF10585@kroah.com>
References: <2ee2b9470701130211i420fc26dm2fff9ecfcc6293f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee2b9470701130211i420fc26dm2fff9ecfcc6293f0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 01:11:59PM +0300, Vladislav Dembskiy wrote:
> Dear Kernel developers,
> 
> I am running 2.6.19.2 kernel on ASUS W2V laptop and I have the
> following boot messages"
> ....
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04)
> (try 'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
> ....
> 
> Could you fix the problem? Please, find attached dmesg reports with
> and without pci-assign-busses option. Also I have attached lspci
> output for your convenience.
> 
> Please, ask for any additional information you need via ved@lenta.ru

Despite the messages at boot time, is the system working properly?

Unfortunatly the developer who added that message to the kernel seems to
have run away and doesn't answer any emails anymore.  But I would
suggest trying Bernhard Kaindl <bk@suse.de> (on the CC:) for help with
this issue.

thanks,

greg k-h
