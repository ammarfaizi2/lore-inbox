Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274307AbRITEn6>; Thu, 20 Sep 2001 00:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274310AbRITEnr>; Thu, 20 Sep 2001 00:43:47 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:64693 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S274307AbRITEn3>;
	Thu, 20 Sep 2001 00:43:29 -0400
Date: Wed, 19 Sep 2001 21:42:43 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2001-09-19 release of hotplug scripts
To: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Message-id: <005b01c1418e$b08433a0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <20010424124116.A13291@kroah.com> <20010919174402.A17423@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've just packaged up the latest Linux hotplug scripts into a release,
> which can be found at:
> http://sourceforge.net/project/showfiles.php?group_id=17679
> 
> This release adds ieee1394 support and a try at SuSE support :)

And various bugfixes ... :)


> Here's the full changelog:
> - Added ieee1394.agent from Kristian Hogsberg
>   <hogsberg@users.sourceforge.net>
> - with docs, "sh -x" debug support, minor fix.  Needs kernel
>   2.4.10 and modutils 2.4.9 to hotplug.

To clarify, the ieee1394 support is what needs software that's
as-yet not quite released.  Other hotplugging (USB, PCI, network)
still works just fine with 2.4.0 (and, for USB, 2.2.current).  The
release is not (as one person suspected :) Science Fiction!


> - Some of the updates from SuSE:

... excluding most of the SuSE-specific admin stuff, so
for now SuSE users will need to get an RPM from SuSE
that knows and uses those hooks.  (Much like the way
the Debian and RedHat distros re-use this software.)

I figure converging admin between such distros is not a near
term possibility, but testing for each distro's admin hooks
and then using them is achievable.  We're not quite there
yet, but the size of the distro-specific patches should be
shrinking over time ... :)

- Dave



