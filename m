Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWGCWXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWGCWXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWGCWXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:23:53 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:48782 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932165AbWGCWXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:23:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=e+XFVJONf9ksdqFQs24FXS+g9ZWjdnAuzKIt9GysYYZHcwUsnM8yyliubK6PBvW7wWNJC6q2hUGfrdEyYxTkwz9jCuCORcTWLbCsjdvtj/5Aut+Gj+JxLwYDmXrAqkEZFI0INqYmo5UyhIa9pzUB22HBVt3WJ4raGSjyWCAgXVc=
From: Romit <romit.linux@gmail.com>
Reply-To: romit.linux@gmail.com
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG for udev to work?
Date: Tue, 4 Jul 2006 03:57:13 +0530
User-Agent: KMail/1.8.2
References: <200607040332.48506.romit.linux@gmail.com> <6bffcb0e0607031514r6e14c68am5964f07265e0caeb@mail.gmail.com>
In-Reply-To: <6bffcb0e0607031514r6e14c68am5964f07265e0caeb@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607040357.14123.romit.linux@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,
             Thanks. I checked the udev version and it is 068. Meanwhile, what 
I did was I booted into 2.6.13-15 and
zcat /proc/config.gz > $(KERN_SOURCEDIR_2.6.17.1)/
and then ran 
make xconfig.

Ofcourse there were some CONFIG options that were present in 2.6.13-15 and 
missing in 2.6.17.1 and vice versa but once I resolved those and built the 
kernel, udev seems to be working. So I did not upgrade udev to 071 but still 
it works. I think there should be some CONFIG option that I am missing. I am 
not sure which one. 
Thanks again,
-Romit



On Tuesday 04 July 2006 03:44, you wrote:
> Hi,
>
> On 04/07/06, Romit <romit.linux@gmail.com> wrote:
> > Hi,
> >
> >     I sent a query to linux-hotplug-devel a few days back but did not get
> > any reply, so I am posting it here.
> > I upgraded from 2.6.13-15  to 2.6.17.1 and I can't see any UEVENT message
> > generation. I am running udevmonitor and it is just blocking on receiving
> > UEVENT from the kernel even after I insert a usb keyboard/ usb storage /
> > usb bluetooth dongle.
> > I am running SUSE LINUX 10.0.
> > I am sure that I am missing some CONFIG iitem. All I want to know is what
> > arethem essential items that I need to enable for udev to work.Kindly let
> > me know what CONFIG item I am missing.
>
> Documentation/Changes
>
> "udev            071                     # udevinfo -V"
>
> > Thanks in advance
> > -Romit
>
> Regards,
> Michal
