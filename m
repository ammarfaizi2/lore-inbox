Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWASUMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWASUMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWASUMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:12:14 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:875 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161382AbWASUMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:12:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sqda2OabrTqs78mx4xZQPlOnFs8riyZFzIALDP7t8UWIwXc0WqZlihQOhZzcjXdK8fsIrKgEeNfm2u6PVvIB3xhzRSqAkHEIeBZ9G6JQo497/zOSRQEcaaQpNwoT6enZoTPCHnd8G0paPdxEL9xhrp4RCsocRJsf4p5QcR0D+6Q=
Message-ID: <a44ae5cd0601191205r269a8abcrc76c2961be374fd9@mail.gmail.com>
Date: Thu, 19 Jan 2006 12:05:08 -0800
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] Error 2"
In-Reply-To: <a44ae5cd0601191159y4801d6b6ld45785b7e7e356b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com>
	 <200601191105.k0JB5sKN012313@typhaon.pacific.net.au>
	 <a44ae5cd0601191159y4801d6b6ld45785b7e7e356b8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/06, Miles Lane <miles.lane@gmail.com> wrote:
> I checked and /dev/null exists.  I also have libncursesw5 installed.
> Oddly, I rebooted and when I ran make, the build proceeded.  I quit
> and ran "make menuconfig" again.  As you suggested, this did break
> my build process as before.  I had to reboot in order to complete the
> build process.  Any other possibilities?

Huh.  Weird.  Now it is all happy.  I did install libncursesw5-dev
last night, but I was able to reproduce the problem afterwards.
I allowed one full build to complete, ran make (clean, menuconfig,
and all) and it is still working.  Go figure.

         Miles
