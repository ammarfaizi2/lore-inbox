Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSH0S10>; Tue, 27 Aug 2002 14:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSH0S10>; Tue, 27 Aug 2002 14:27:26 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:35851 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316675AbSH0S10>;
	Tue, 27 Aug 2002 14:27:26 -0400
Date: Tue, 27 Aug 2002 11:31:19 -0700
From: Greg KH <greg@kroah.com>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse problem, kernel panic on startup in 2.4.19
Message-ID: <20020827183119.GB23700@kroah.com>
References: <200208272011.51691.felix.seeger@gmx.de> <200208272023.52351.felix.seeger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208272023.52351.felix.seeger@gmx.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 08:23:47PM +0200, Felix Seeger wrote:
> Kernel BUG at usb-ohci.h:464!

Can you try the patch at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-usb-ohci-2.4.20-pre4.patch
and let us know if it fixes this problem or not?

thanks,

greg k-h
