Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVCOVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVCOVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVCOVX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:23:59 -0500
Received: from isilmar.linta.de ([213.239.214.66]:17629 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261849AbVCOVXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:23:47 -0500
Date: Tue, 15 Mar 2005 22:23:45 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: David Brownell <david-b@pacbell.net>
Cc: dtor_core@ameritech.net, linux-usb-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315212345.GA4950@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	David Brownell <david-b@pacbell.net>, dtor_core@ameritech.net,
	linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <200503151235.02934.david-b@pacbell.net> <d120d50005031512485125db18@mail.gmail.com> <200503151314.40510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503151314.40510.david-b@pacbell.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 01:14:40PM -0800, David Brownell wrote:
> That pre-driver model stuff went away in maybe 2.6.5 or so, I
> forget just when.  If you think those changes can easily be
> reversed, I suggest you think again ... they enabled a LOT of
> likewise-overdue cleanups. 
...
> converting to the driver model has been a win at every step
> of the way.  It's gone both ways; the driver core has changed
> to work better with USB too.

Exactly my point: the driver code forces/encourages you to write better
code. With proper reference counting. And reverting this by making
"class_simple" default, and possibly doing a similar transition for struct
device and struct device_driver means that we lose this encouragement. and
we lose this win-win situation.

Thanks,
	Dominik
