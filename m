Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUJMJiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUJMJiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 05:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUJMJiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 05:38:50 -0400
Received: from asav2.lyse.net ([213.167.96.69]:51174 "EHLO asav2.lyse.net")
	by vger.kernel.org with ESMTP id S267890AbUJMJir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 05:38:47 -0400
From: Alexander Wigen <alex@wigen.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
Date: Wed, 13 Oct 2004 19:32:28 +0000
User-Agent: KMail/1.7
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Oleksiy <Oleksiy@kharkiv.com.ua>, LKML <linux-kernel@vger.kernel.org>
References: <416A6CF8.5050106@kharkiv.com.ua> 
	<20041011113609.GB417@logos.cnet> 
	<20041012104848.530a5be7@lembas.zaitcev.lan>
In-Reply-To: <20041012104848.530a5be7@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410131932.28896.alex@wigen.net>
X-imss-version: 2.7
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:4 M:0 S:100 R:5
X-imss-settings: Baseline:4 C:4 M:4 S:3 R:3 (1.0000 50.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 October 2004 17:48, Pete Zaitcev wrote:
> On Mon, 11 Oct 2004 08:36:09 -0300
>
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > Pete,
> >
> > I bet this has been caused by your USB changes?
> >
> > > [...] So i decided to test all
> > > kernels between 2.4.26 and 2.4.28-pre4 (also not working). Link works
> > > well in 2.4.27-pre5 and stop working in 2.4.27-pre6.
>
> I'm afraid you're right, because Oleksiy did the bisection. However,
> I cannot see how this is possible. In fact, it fixed ppp for a few
> people...
>
> This may be something pl2303 specific. I'll work with Oleksiy to get
> to the bottom of it.
>
> -- Pete

May I add that I have some problems with a pl2303 GPS device which causes 
kernel panics when I pull it out of the USB port.

I don't know if it can be related, the device works fine until I unplug it.

Cheers
Alexander Wigen
-- 
Homepage: http://www.wigen.net   Mail: alex@wigen.net
If you don't believe in oral sex, keep your mouth shut.
