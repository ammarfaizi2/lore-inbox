Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292991AbSBVUsS>; Fri, 22 Feb 2002 15:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292994AbSBVUsK>; Fri, 22 Feb 2002 15:48:10 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:49936 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292991AbSBVUrf>;
	Fri, 22 Feb 2002 15:47:35 -0500
Date: Fri, 22 Feb 2002 12:41:57 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222204157.GG9558@kroah.com>
In-Reply-To: <20020222200750.GE9558@kroah.com> <20020221221842.V1779-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020221221842.V1779-100000@gerard>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 25 Jan 2002 16:56:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 10:24:22PM +0100, Gérard Roudier wrote:
> 
> Thanks for the reply. But my concern is user convenience in _average_
> here. Basically, I want the 99% of users that cannot afford neither need
> nor want PCI hotplug to have their system just dead in order to make happy
> the 1%.
> 
> In other word, I donnot care about this 1% if it makes run a tiny risk to
> the 99% to get inconvenience a single second. Btw, I am among the 99%.

With some of the upcoming changes int 2.5 (like initramfs), it will be
more important than ever to move to the current PCI API.

I'm not saying that you are being forced to convert the code, but more
and more the driver will not work with new features.

Right now I just point people to the Adaptec cards when they complain
about their controllers not working with hotplug :)

thanks,

greg k-h
