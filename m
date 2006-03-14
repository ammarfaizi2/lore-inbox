Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWCNAw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWCNAw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWCNAw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:52:56 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:25398 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751899AbWCNAwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:52:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=oBOHovwz0bFHq0Q1+suWMNr4irFFWac4Wz47rqkv76LwmiRpDNkUzdMZBxyfVCe1tIS+z4eKeDsRUZIwASRit0ulJLFXyTjTSfYrwUtY2fDrwW1iOudHMVcfTIPhjBrtO5vm+aiyCQK/km5tAf7jRz9ZRbtt3/JWC/19OxV72/c=
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: j4K3xBl4sT3r <jakexblaster@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
	 <7c3341450603121247n7afe018m@mail.gmail.com>
	 <436c596f0603121632qe3151k793fd3ccd9a0eacb@mail.gmail.com>
	 <200603130708.13685.nick@linicks.net>
	 <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 16:52:52 -0800
Message-Id: <1142297572.7090.4.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 08:42 -0300, j4K3xBl4sT3r wrote:

> 1. before, the mouse worked fine. now, it doesnt works
> 2. before, the sound worked. and now, still working, just with ALSA,
> no OSS support (tested with mpg321 and ogg123 on bash terminal)
> 3. strangely, the X worked fine after the kernel update, is DRM and
> AGPGART needed by Xorg?
> 4. before, the PPPoE connected within the 2 first "." (seconds?). Now,
> doesnt work, I always get TIMEOUT from PPPoE.
> 5. the PNPDUMP returns a empty file on the isapnptools (from the
> compilation, this is the only file that gets fully compiled)
> 
> This situation happened on the Slackware 10.2, assuming a Kernel
> Update.

I'm running Slackware 10.2 on my server with the 2.6 kernel. Did you
remember to chmod +x /etc/rc.d/rc.udev? It is either an issue with /dev
or an issue with the drivers not being initialized correctly.

--
Chris Largret <http://daga.dyndns.org>

