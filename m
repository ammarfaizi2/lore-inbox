Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVERH2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVERH2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVERH2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:28:32 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:34336 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261979AbVERH2Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:28:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GPMNg79hrq2j45G4KzooY798C99qsjJqI02DG0MrnSZFQrHVjlkuOzaafF+uqEXsLQMa0URUg3KgS0aEa0ckBuOGuPUIh06JWi8tFXHjz2iA5tJtKFnainOMIpGwnkTc1CzcHpQopeTp+o4R7RsF4Whjy72qjvSEG72NogLY1rU=
Message-ID: <253818670505180028696cc991@mail.gmail.com>
Date: Wed, 18 May 2005 03:28:23 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks) device attribute callbacks - take 2
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20050518072239.GA11889@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051703394944e949@mail.gmail.com>
	 <20050518072239.GA11889@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 5/18/05, Greg KH <greg@kroah.com> wrote:
> Ok, I think I got all of these patches applied properly (hint, don't
> label your intro message as 1/15, it should be 0/14, with 14 different
> patches, that threw me off for a bit.)  I've also included your i2c
> driver patch for the adm1026 driver only.  All of these patches are now
> in my tree and can be found on kernel.org in the place where my
> patchscripts notified you.  If you could verify them I would appreciate
> it (I also added a few patches for stuff that was in my tree only, like
> new i2c drivers and some usb and pci sysfs stuff to make them build
> properly.)  All of this should show up in the next -mm release too.

Thanks a lot! Sorry about the incorrect numbering, first time I've
done an intro. I'll have to send you a patch against the differences
between 2.6.12-rc4 and 2.6.12-rc4-mm2 so we don't run into a huge
amount of trouble when they merge...

A quick glance through everything looks fine, but I'll do a proper
check tomorrow using your git tree.

> Thanks a lot for sticking with this process, I really appreciate it.
> Now you can get back to actually fixing up the i2c drivers you wanted
> to, which was what you wanted to do in the first place :)

Yes it will be good to get back to my own area for a bit, maybe even
finally get bmcsensors into a state where it can be accepted :-),
however it has been a nice break and I can see other areas that could
benefit from things along the line of this patch so I might yet
intrude upon the rest of the kernel again ;-).

Thanks,
Yani
