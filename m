Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVIBQYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVIBQYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVIBQYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 12:24:22 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:14321 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbVIBQYV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 12:24:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X25oUaIUOiAj+b5wE6CP24X4dKGgIVGQCfZYWMwM0w/mXYjNk9LwNxIt1bq9wi5gL/uARlfVRuS55lZSAHqPxm9LlJEJ3rsbTu5RL2e2jEhRP8PdPpHLLbhne8+zuYT5Ycss+InzOaRAuTochmm588hz1VvuwJpXb1P9F5GlwBo=
Message-ID: <62b0912f05090209242ad72321@mail.gmail.com>
Date: Fri, 2 Sep 2005 18:24:20 +0200
From: Molle Bestefich <molle.bestefich@gmail.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: IDE HPA
Cc: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <E1EBCdS-00064p-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > If one does not care to use the HPA, one should disable it in the
> > BIOS entirely, so that everywhere (!) the entire disk is seen.
>
> And in the real world BIOSes don't get updated often
> by vendors let alone by users.

I meant the BIOS setup screen, not a firmware update...
Supposedly the BIOS can change the bounds of the HPA with special ATA commands..

Matthew Garrett wrote:
> Molle Bestefich wrote:
> > If HPA were exposed as /dev/.../hpa then it wouldn't be possible to
> > create such a filesystem. I'm guessing it's not possible with Windows
> > either, or with any BIOS-based OS.
> 
> Such filesystems already exist. Changing this behaviour now would break
> existing setups.

Not if, as proposed, there was a kernel switch to enable including the
HPA in the disc area.
Also those who has such filesystems {c,sh}ould disable HPA in their
BIOS (hopefully).
