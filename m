Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316858AbSE1RdX>; Tue, 28 May 2002 13:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSE1RdV>; Tue, 28 May 2002 13:33:21 -0400
Received: from www.transvirtual.com ([206.14.214.140]:28178 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316858AbSE1Rcb>; Tue, 28 May 2002 13:32:31 -0400
Date: Tue, 28 May 2002 10:32:17 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Paul Mackerras <paulus@samba.org>
cc: Russell King <rmk@arm.linux.org.uk>,
        A Guy Called Tyketto <tyketto@wizard.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.18-dj1
In-Reply-To: <15600.51720.488266.491713@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.10.10205281031270.16297-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That looks like my patch.  It stops the oops (by fixing a signed
> vs. unsigned comparison bug) but doesn't fix the colormap handling.
> On my G4 powerbook, which has an ATI Rage 128 (Mobility M3 AGP 2x) the
> screen colours are all totally wrong under X when I boot 2.5.18.  I
> have Option "UseFBDev" in my /etc/X11/XF86Config-4, so the X server is
> using the kernel frame buffer driver to do colormap updates.  (The
> colours are all OK on the text consoles though.)

Where is the latest ATI 128 driver? I like to port it over to the new api.


