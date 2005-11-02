Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVKBRfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVKBRfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVKBRfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:35:03 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:30052 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750722AbVKBRfC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:35:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ihI51Av25FX1x4tcK4rwzaH/PZAwdh620g/mhGz9SApDWHrbFU3xsJ0FqAj8AaAOQfuT5vNLuwVjzdqAQ+Y8z756cUFe/qULUWsB5SFjyxKlhpNDdzM2i5gLLQxe2Dyr1hHJ1N7Mevjdt9HWajGUMeJouv2T8+j3EJvcxpTFsAY=
Message-ID: <6278d2220511020935g6f88d15bp5f1e3bc692c55fe8@mail.gmail.com>
Date: Wed, 2 Nov 2005 17:35:00 +0000
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: cpuset - question
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Simon.Derr@bull.net,
       Sylvain.Jeaugey@bull.net
In-Reply-To: <Pine.LNX.4.58.0511020825450.6456@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6278d2220511020236l26f74eecp11910e59fd1c432d@mail.gmail.com>
	 <Pine.LNX.4.58.0511020825450.6456@shark.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure of the true answer; it is likely that CPUSETS was
designed in the 2.4 timeframe and compatibility was preferred over the
clean sysfs interface.

I've CC'd the authors.

Dan

On 11/2/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Wed, 2 Nov 2005, Daniel J Blueman wrote:
> >
> > Janos,
> >
> > You can see what valid memory nodes are available from the top-level
> > cpuset directory:
> >
> > # cat /dev/cpuset/mems
> > 0 1 2 3
> >
> > If you were to be running on a NUMA-capable system, you'd also want to
> > ensure page interleaving was disabled in the BIOS/pre-boot firmware
> > too.
>
> Just for info, why is this in /dev at all, instead of, say,
> /sys ??
>
> --
> ~Randy
___
Daniel J Blueman
