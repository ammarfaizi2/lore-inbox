Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbSLSXbz>; Thu, 19 Dec 2002 18:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267659AbSLSXbz>; Thu, 19 Dec 2002 18:31:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6661 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267655AbSLSXbw>;
	Thu, 19 Dec 2002 18:31:52 -0500
Date: Thu, 19 Dec 2002 15:37:01 -0800
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: bus_type and device_class merge (or partial merge)
Message-ID: <20021219233701.GA8536@kroah.com>
References: <Pine.LNX.4.33.0212191355370.1286-100000@localhost.localdomain> <200212192244.OAA06433@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212192244.OAA06433@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 02:44:53PM -0800, Adam J. Richter wrote:
> >> = Adam Richter
> >  = Patrick Mochel
> 
> >Especially during the continuing evolution
> >of the model. At least for now, and for probably a very long time, I will 
> >not consider patches to consolidate the two object types.
> 
> 	Linux will be better if we decide things by weighing technical
> benefits rather than by attempts at diktat.  I recommend you keep an
> open mind about it.

Heh, if anyone has kept an open mind around here, it's Pat.  Look at the
crap that the driver writers have forced him to accommodate.  Here's a
small drawing that some people did at OLS 2002 to help get across how
all of the wide range of busses, classes, devices, and drivers interact
with just one kind of subsystem:
	http://www.kroah.com/linux/images/driver_model_1_ols_2002.jpg

The existing code handles monstrosities like that quite well, because he
has kept an open mind, and listened to the driver and subsystem authors.

And yes, we need to start writing more class support, it's next on my
list too.  Patches to do this would be greatly appreciated.

thanks,

greg k-h
