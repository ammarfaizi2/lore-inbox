Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbSIRGrR>; Wed, 18 Sep 2002 02:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265676AbSIRGrR>; Wed, 18 Sep 2002 02:47:17 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:37126 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265675AbSIRGrQ>;
	Wed, 18 Sep 2002 02:47:16 -0400
Date: Tue, 17 Sep 2002 23:52:25 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <duncan.sands@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.26 hotplug failure
Message-ID: <20020918065225.GB6840@kroah.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <20020718183617.GI15529@kroah.com> <200209152353.41285.duncan.sands@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209152353.41285.duncan.sands@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 11:53:41PM +0200, Duncan Sands wrote:
> 
> A simple fix is to change the test to [ $COUNT -lt 2 ];

Good catch, yes the drivers file disappeared, and until now, almost no
one noticed it :)

I'll go apply this patch.

Thanks again for finding this.

greg k-h
