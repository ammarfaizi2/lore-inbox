Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVIVL26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVIVL26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 07:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVIVL26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 07:28:58 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:11026 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030258AbVIVL26 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 07:28:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MjiQ8w4tmQixMatvQwZ3P2pi5cNQQbH0oN88AiVVfJkUXHH+mpeWELE69m7amTid+aTsMe6YP+UEFzoGn7MPsT7VxP/r9D+9/kicWz3aEfSTNJVf7lRllQYTX6zqzCSa9rV3m3EUNeboRyED/Pbx/2izVFh9+epvkVQHAeVL4xI=
Message-ID: <40f323d005092204283770b416@mail.gmail.com>
Date: Thu, 22 Sep 2005 13:28:56 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Ed Sweetman <safemode@comcast.net>
Subject: Re: ipw2200 Broken 2.6.13: "firmware_loading_store: unexpected value (0)"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43328C2B.8060302@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43328C2B.8060302@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/05, Ed Sweetman <safemode@comcast.net> wrote:
> I'm using 2.6.13-mm1, and i tried both 1.0.6 and the included driver
> (both matched with the appropriate ieee80211 driver) and I'm using
> debian unstable's version of hotplug Version: 0.0.20031013-2.   I have
> very little installed on this computer as it's a WRAP board with mini
> pci intel 2915.  Is anything in userspace required to load firmware
> besides hotplug? I dont use udev or devfs ...not sure if there are /dev
> entries or what.
>
> I'm getting this error constantly (thousands of times a second when
> modprobing the ipw2200 driver (any version)
>
> firmware_loading_store: unexpected value (0)
>
>
> I have the firmware available in every possible accepted location for
> firmware.   I have no doubt that it's finding the firmware, but unable
> to load it.  My sysfs driver directory for the pci device has no "data"
> file/directory in it, which I thought is where firmware is loaded.
>
> If any other info is required to figure this problem out.  Just mention
> it.  I'll provide everything.  Attached is my config for the kernel in
> question.
>

you should upgrade to at least .13-mm3 or revert :
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/broken-out/gregkh-driver-sysfs-strip_leading_trailing_whitespace-fix.patch


regards,

Benoit Boissinot
