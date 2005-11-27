Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVK0GJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVK0GJo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 01:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVK0GJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 01:09:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:46860 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750890AbVK0GJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 01:09:43 -0500
Date: Sun, 27 Nov 2005 07:09:38 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Brown <dmlb2000@gmail.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.14.tar.bz2 permissions
Message-ID: <20051127060937.GN11266@alpha.home.local>
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <200511270138.25769.s0348365@sms.ed.ac.uk> <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com> <200511270151.21632.s0348365@sms.ed.ac.uk> <9c21eeae0511261756r65d0f4b7l96b0e1089c4c62bc@mail.gmail.com> <29495f1d0511261827s7984bea8l92149b8a3091e6d8@mail.gmail.com> <9c21eeae0511261838ncec563v1739a1230347365b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c21eeae0511261838ncec563v1739a1230347365b@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 06:38:22PM -0800, David Brown wrote:
> > Uh, untarring is the operation that needs to be non-root. So just have
> > a build user or some other non-root user do the untarring and building
> > (which is recommended by most anyways, IIRC). Then, as root (or via
> > sudo) make modules_install install.
> 
> This isn't an excuse to have unsecure permissions when extracting as
> root though.

It certainly is not an excuse, but at least it my explain why nobody
noticed it before you :-)

Regards,
Willy

