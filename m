Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVBSTzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVBSTzF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 14:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVBSTzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 14:55:05 -0500
Received: from gw.goop.org ([64.81.55.164]:11911 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261772AbVBSTzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 14:55:02 -0500
Message-ID: <42179991.6090808@goop.org>
Date: Sat, 19 Feb 2005 11:54:57 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Hotplug blacklist and video devices
References: <9e4733910502181251ea2b95e@mail.gmail.com>	 <20050218210822.GB8588@nostromo.devel.redhat.com>	 <9e47339105021813146cf69759@mail.gmail.com>	 <E1D2TjV-0007r9-00@chiark.greenend.org.uk> <9e47339105021907561c4f408c@mail.gmail.com>
In-Reply-To: <9e47339105021907561c4f408c@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

>I didn't say make framebuffer depend on DRM, you can still unload DRM
>before suspend.  It's the other way around DRM needs framebuffer.
>
Only if you want to see the output, surely?  I have an application which 
doesn't need a framebuffer (or more strictly, scan-out), but does use DRM.

    J
