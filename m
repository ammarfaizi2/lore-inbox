Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSCMQin>; Wed, 13 Mar 2002 11:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310787AbSCMQie>; Wed, 13 Mar 2002 11:38:34 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:5380 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310783AbSCMQiU>;
	Wed, 13 Mar 2002 11:38:20 -0500
Date: Wed, 13 Mar 2002 08:38:28 -0800
From: Greg KH <greg@kroah.com>
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-to-serial 2303
Message-ID: <20020313163828.GA1951@kroah.com>
In-Reply-To: <1016020663.31918.10.camel@star8.planet.rcn.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1016020663.31918.10.camel@star8.planet.rcn.com.hk>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 13 Feb 2002 14:33:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 07:57:42PM +0800, David Chow wrote:
> Hi, I've got a pl2303 adapter running 2.4.17 . I cannot write any
> commands to my modem but I still read "RING" with some corrupted output
> from my /dev/ttyUSB0 port. Is this driver still in beta or not working?
> I would like to get some hints thanks.

I do not know of any outstanding problems with this driver, no.
Can you load it with "debug=1" on the modprobe line and see if there is
any odd messages in the kernel debug log?

thanks,

greg k-h
