Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTCJWM4>; Mon, 10 Mar 2003 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261658AbTCJWM4>; Mon, 10 Mar 2003 17:12:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4868 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261530AbTCJWMl>;
	Mon, 10 Mar 2003 17:12:41 -0500
Date: Mon, 10 Mar 2003 14:12:48 -0800
From: Greg KH <greg@kroah.com>
To: Albert Cranford <ac9410@attbi.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] driver core support for i2c bus and drivers
Message-ID: <20030310221248.GD13145@kroah.com>
References: <20030310072337.GJ6512@kroah.com> <3E6D0D25.26B5584F@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6D0D25.26B5584F@attbi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 05:09:41PM -0500, Albert Cranford wrote:
> I like.  The proc/bus directory was geting cluttered.

Heh, that's an understatement :)

> I think the driver model would be a good for i2c/sensors.

It seems to fit quite nicely, and should clean up a lot of the sysctl
madness that you have been forced to live with for 2.0, 2.2, and 2.4.

> Do you have any input for isa already in your bag of
> goodies?

Yes, the i2c-isa driver should add itself to the sys/devices/legacy
tree, I just hadn't added that patch yet, still bickering with Pat about
the interface to register devices there :)

thanks,

greg k-h
