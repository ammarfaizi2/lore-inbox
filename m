Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968692AbWLEUk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968692AbWLEUk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968693AbWLEUk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:40:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:55026 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968692AbWLEUky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:40:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K4VbruDAmbwyygy9bFCiNzaLyPLQR0ttAS2u8xM911n856sc9NrQ2w8SPMiT1xPZjx+Hbv6YSZkX0+U9Ojk3ZIWofyb1pYmbtFtBXbmJaJNzXBSfaU/SGp5AQS7CvIp0/vvsS+cRjUFi+0blMlvbnEcI0xVSgLa+11TigDPZP/4=
Message-ID: <653402b90612051240s7beeda1hd9c1c6f9b5d6721d@mail.gmail.com>
Date: Tue, 5 Dec 2006 21:40:52 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: -mm merge plans for 2.6.20
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Yu Luming" <luming.yu@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061204204024.2401148d.akpm@osdl.org>
	 <Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
	 <20061205100140.24888a96.akpm@osdl.org>
	 <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > > > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> > >
> > > Does this patch update the fbdev drivers?
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/broken-out/video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> >
> > Seems not.  Should it?
>
> Yes. Its bizarre. The drivers compile with the wrong method prototype. I
> updated the fbdev drivers to the new backlight_device_register and it
> compiled as expect. There are a few other problems with teh fbdev drivers.
> I will send a patch.
>
> > > > add-display-output-class-support.patch
> > > > add-output-class-document.patch
> > > > drivers-add-lcd-support-3.patch
> > > > drivers-add-lcd-support-3-Kconfig-fix.patch
> > > > drivers-add-lcd-support-update-4.patch
> > > > drivers-add-lcd-support-update-5.patch
> > > > drivers-add-lcd-support-update6.patch
> > > > drivers-add-lcd-support-update-7.patch
> > > > drivers-add-lcd-support-update-8.patch
> > >
> > > Ug. We have alot of interfaces attempting to do the same thing. We also
> > > have the lcd class_dev in drivers/video/backlight. I did some work which I
> > > will post to interested parties in the hopes of getting one interface to
> > > make everyone happy.
> >
> > Well can you please work out what we should do with Miguel?
>
> I sent a email already. The details will be hammered out.
>
>

Right back from exams and with lots of spare time :)

I got your patch, so I'm going to try your patch and exchange all the
"platform_device_*" stuff with your display class and move ks0108,
cfag12864b and cfag12864bfb to drivers/video/display/

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
