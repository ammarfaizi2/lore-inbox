Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSFDQuq>; Tue, 4 Jun 2002 12:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315232AbSFDQuO>; Tue, 4 Jun 2002 12:50:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35084 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315214AbSFDQt2>; Tue, 4 Jun 2002 12:49:28 -0400
Message-ID: <3CFCE1E2.1040906@evision-ventures.com>
Date: Tue, 04 Jun 2002 17:50:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: device model documentation 2/3
In-Reply-To: <Pine.LNX.4.33.0206040918490.654-100000@geena.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> Document 2: driver.txt

> 
> This callback only verifies that there actually is supported hardware
> present. It may allocate a driver-specific structure, but it should
> not do any initialization of the hardware itself. The device-specific
> structure may be stored in the device's driver_data field. 
> 
> 	int	(*init)		(struct device * dev);
> 
> init is called during the binding stage. It is called after probe has
> successfully returned and the device has been registered with its
> class. It is responsible for initializing the hardware.

"init is called during the *attachment*."
You see it even sounds more naturall.

