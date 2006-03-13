Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWCMWOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWCMWOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWCMWOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:14:44 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:1776 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932499AbWCMWOn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:14:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PHKyw8ROyS9o4XN6S5JmkYWIwjClhyJQ4CbrR8uSmDa7k1nq44SKQI89jtz3ioqAp+IoWBiBGsuZQwNLiLTdYjlvXjZj4rMKx/5DVwMl58jBKOcLj4jgFOhuaGb8ur81y73rn9ewUsz1DMOa8ls4QA1EMqXk2zu0KH8Xwtxsukw=
Message-ID: <d6e463920603131414q357b4484rb222819895c93526@mail.gmail.com>
Date: Mon, 13 Mar 2006 14:14:22 -0800
From: "Nathan Laredo" <laredo@gnu.org>
To: "Johannes Stezenbach" <js@linuxtv.org>
Subject: Re: [v4l-dvb-maintainer] Re: 2.6.16-rc6: known regressions
Cc: "Greg KH" <gregkh@suse.de>, "Adrian Bunk" <bunk@stusta.de>,
       "Andrew Morton" <akpm@osdl.org>, video4linux-list@redhat.com,
       norsk5@xmission.com, "Jiri Slaby" <jirislaby@gmail.com>,
       paulus@samba.org, linux-usb-devel@lists.sourceforge.net,
       linux-acpi@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       len.brown@intel.com, xfs-masters@oss.sgi.com,
       "Linus Torvalds" <torvalds@osdl.org>, anton@samba.org,
       "Dave Jones" <davej@redhat.com>, v4l-dvb-maintainer@linuxtv.org,
       dsp@llnl.gov, "Avuton Olrich" <avuton@gmail.com>,
       "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com, pete.chapman@exgate.tek.com,
       "Olaf Hering" <olh@suse.de>, bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <20060313212215.GA6041@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
	 <20060313200544.GG13973@stusta.de> <20060313121219.GB13652@suse.de>
	 <20060313212215.GA6041@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stradis does not support my driver.   Please use
http://stradis.nathanlaredo.com/  such as it is now and I'll update it
later.

Secondly, please confirm that the person reporting this bug actually
has the hardware since the driver *will* refuse to load without
hardware installed.

To my knowledge I am currently the only one of about 10 people using
this hardware under linux.

Thanks,
-- Nathan Laredo
laredo@gnu.org

On 3/13/06, Johannes Stezenbach <js@linuxtv.org> wrote:
> On Mon, Mar 13, 2006 at 12:12:19PM +0000, Greg KH wrote:
> > On Mon, Mar 13, 2006 at 09:05:44PM +0100, Adrian Bunk wrote:
> > > Subject    : Stradis driver udev brekage
> > > References : http://bugzilla.kernel.org/show_bug.cgi?id=6170
> > >              https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
> > >              http://lkml.org/lkml/2006/2/18/204
> > > Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
> > >              Dave Jones <davej@redhat.com>
> > > Handled-By : Jiri Slaby <jirislaby@gmail.com>
> > > Status     : unknown
> >
> > Jiri, why did you create a kernel.org bugzilla bug with almost no
> > information in it?
> >
> > Anyway, this is the first I've heard of this, more information is
> > needed to help track it down.  How about the contents of /sys/class/dvb/ ?
>
> Stradis is not a DVB driver. AFAIK it uses V4L devices.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=6170 and
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
> seem to be two totally different bugs. First thing to check
> for the Nova-T is dmesg, to see if the device was recognized
> at all by the driver, so we know if it is an udev
> problem or not.
>
>
> BTW: http://mpeg.openprojects.net/ doesn't exist
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d7d30d..922a290 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2525,7 +2525,6 @@ S:        Unsupported ?
>  STRADIS MPEG-2 DECODER DRIVER
>  P:     Nathan Laredo
>  M:     laredo@gnu.org
> -W:     http://mpeg.openprojects.net/
>  W:     http://www.stradis.com/
>  S:     Maintained
>
>
> Johannes
>
