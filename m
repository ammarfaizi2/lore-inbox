Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSLXWEu>; Tue, 24 Dec 2002 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265901AbSLXWEu>; Tue, 24 Dec 2002 17:04:50 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6417 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265898AbSLXWEu>;
	Tue, 24 Dec 2002 17:04:50 -0500
Date: Tue, 24 Dec 2002 14:09:13 -0800
From: Greg KH <greg@kroah.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM][2.5.52/53][USB] USB Device unusable
Message-ID: <20021224220913.GA3237@kroah.com>
References: <200212241533.21347.spstarr@sh0n.net> <20021224204029.GB3052@kroah.com> <200212241652.45041.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212241652.45041.spstarr@sh0n.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 04:52:44PM -0500, Shawn Starr wrote:
> 2.5.53-mm1 compiled w/ lm_sensors merged in:
> 
> Same error however new thing:
> 
> When a non-root user tries to configure the USB device the userland program 
> returns 'Unable to claim USB device'

So you are using usbfs?  What program?  Nothing changed with usbfs from
2.5.52 to 2.5.53, but some things did change from 2.5.50 to 2.5.51.  Did
.50 work for you?

thanks,

greg k-h
