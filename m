Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293010AbSBVVs1>; Fri, 22 Feb 2002 16:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293009AbSBVVsR>; Fri, 22 Feb 2002 16:48:17 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:56848 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293010AbSBVVsD>;
	Fri, 22 Feb 2002 16:48:03 -0500
Date: Fri, 22 Feb 2002 13:42:25 -0800
From: Greg KH <greg@kroah.com>
To: Erik Andersen <andersen@codepoet.org>,
        =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222214225.GA10333@kroah.com>
In-Reply-To: <20020222200750.GE9558@kroah.com> <20020221221842.V1779-100000@gerard> <20020222204157.GG9558@kroah.com> <20020222213014.GB30290@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020222213014.GB30290@codepoet.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 25 Jan 2002 19:36:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 02:30:14PM -0700, Erik Andersen wrote:
> On Fri Feb 22, 2002 at 12:41:57PM -0800, Greg KH wrote:
> > 
> > Right now I just point people to the Adaptec cards when they complain
> > about their controllers not working with hotplug :)
> 
> Well, even aic7xxx actually don't do hotplug correctly either.
> Or more accurately, with my Adaptec 1480B I can hotplug, and I
> can then hot-unplug, but I can't hotplug again...  Just try
> pulling the 1480 card and then doing a 
>     cat /proc/scsi/aic7xxx/0
> some time and watch all the fireworks,

Hm, I didn't try the 'cat' test, but I did successfully unplug and then
add a card, and then spin up the drives attached to that drive.  But
that was a long time ago.  Things might have changed since then.

This is with a cardbus device, right?  I have never looked into them
before.

thanks,

greg k-h
