Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVCAGOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVCAGOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCAGOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:14:35 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:11861 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261255AbVCAGIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:08:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=syFcBSixxy7JuTdYlfexDPJV6Z8qYuH5hdFFyftay7QdBRZe6THxFx7W5if+5ZwUsohzsVUsECGyteePFp01eighyDrcSmch8ubNJc/8VJM7skg4zVKq+XYGTsQ0x6Ax/8mimK3z3ACgiKwHibpv7h1QizLf11Mqc+TBwO952Yo=
Message-ID: <9e47339105022822079eb6f86@mail.gmail.com>
Date: Tue, 1 Mar 2005 01:07:51 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: RFC: disallow modular framebuffers
Cc: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <4223E59D.3060902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050301024118.GF4021@stusta.de> <4223E59D.3060902@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The on-going work to support XGL is going to change the significance
of modular framebuffers. Right now there is no real need to load
framebuffers on X86. In the future XGL is probably going to require
that the framebuffer be loaded. When XGL initially starts being
distributed people are not going to have framebuffer loaded so modular
framebuffer will let you load it on demand. From then on, in the XGL
case, if framebuffers weren't modular Redhat would have to compile all
75 of them into their distro kernel.

I don't think the framebuffer codebase has received the same level of
inspection that a lot of the other kernel code has. This is probably
because all X86 users can currently avoid loading them due to VGA
compatibility.

-- 
Jon Smirl
jonsmirl@gmail.com
