Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292968AbSCSVvI>; Tue, 19 Mar 2002 16:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292888AbSCSVvD>; Tue, 19 Mar 2002 16:51:03 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:20495 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292968AbSCSVuq>;
	Tue, 19 Mar 2002 16:50:46 -0500
Date: Tue, 19 Mar 2002 13:50:02 -0800
From: Greg KH <greg@kroah.com>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System hanging at boot with ms natural pro keyboard in usb port (2.4.18)
Message-ID: <20020319215001.GD463@kroah.com>
In-Reply-To: <200203192204.32846.felix.seeger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 19 Feb 2002 18:12:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 10:04:28PM +0100, Felix Seeger wrote:
> Hi
> I tried to connect my MS Natural Pro keyboard and than I get this error.
> The Logitech mouse works great ;)
> 
> Is this solved in 2.4.19-pre3 ?
> 
> The error:
> 
> hub.c USB new device connect on bus 1/1, assinged device number 2
> invalid operand: 0000
> CPU:		0
> EIP:		0010:[<d98730a0>] Not tainted
> EELAGS:	0010046
> ... write me if you need more ...

Yes we need more, after you run the oops through ksymoops too.

And what USB host controller driver are you using, and is this a SMP
kernel?

thanks,

greg k-h
