Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbUKCWfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUKCWfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbUKCWY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:24:26 -0500
Received: from mproxy.gmail.com ([216.239.56.249]:45856 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261940AbUKCWP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:15:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Y46sFpLLZnj0O8Wke5/GF6Ozbtq7iEFqN6NhfMJVK3HTXk5lPCSVIUdNV/+hQhIchAme7BC8ZzPIFkDw6MqpgcpBc2p9rkkh2aGGHBMrhFAG6HbW7iZYajPI5tAJj3pvtB+8+HHBYY1ltMzQY4fZX9dDLelKfgqfW30jr/qe+vI=
Message-ID: <21d7e99704110314156bb270de@mail.gmail.com>
Date: Thu, 4 Nov 2004 09:15:58 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: John McGowan <jmcgowan@inch.com>
Subject: Re: Kernel 2.6.9: i810 video
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041103170945.V81684@shell.inch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041102215308.GA3579@localhost.localdomain>
	 <21d7e99704110313583cccde5f@mail.gmail.com>
	 <20041103170945.V81684@shell.inch.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I tried compiling the kernel without the intel810 framebuffer support
> and still, it seems that something writes all over video memory (I did not
> try using the fbdev driver in Xorg when I was trying to get 2.6.9 working,
> just its i180 driver).

Disable the i810 fb and i810 drm and see does X start properly (I
expect it does..)
then just add the DRM and see does it run....

What chipset have you got?

Dave.
