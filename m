Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVBRVOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVBRVOZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVBRVOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:14:24 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:32366 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbVBRVOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:14:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Kl+hK3VxakWprLSR3eQQVbvIqCYmd+Q2QHEnVODKj0qulqvoyuWbSDPgPR8OZTiqipvIk/Hc7UQlMd5HbtKjlecgOBiztFw7/xmq8kqAlWZTJ6sP+ri1RohadrKeVmkepfLEQY0w22GsT2e6xfgf5L0DKpOJqxd0gCXM0w3LEL4=
Message-ID: <9e47339105021813146cf69759@mail.gmail.com>
Date: Fri, 18 Feb 2005 16:14:16 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Hotplug blacklist and video devices
In-Reply-To: <20050218210822.GB8588@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 16:08:22 -0500, Bill Nottingham <notting@redhat.com> wrote:
> Under Fedora (and RHEL), they're there because we generally
> don't want to load them unless the user asked for them.

Is there a specific reason why they are blocked? 

For example I'm looking at making changes to DRM such that DRM will
require the corresponding framebuffer driver to be loaded. If you back
up further this is part of fixing X so that it won't mess with the
hardware from user space. Mode setting would come from the framebuffer
driver instead of the X 2D XAA driver.

-- 
Jon Smirl
jonsmirl@gmail.com
