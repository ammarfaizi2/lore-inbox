Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUIFVR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUIFVR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUIFVR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:17:56 -0400
Received: from the-village.bc.nu ([81.2.110.252]:49826 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266560AbUIFVRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:17:54 -0400
Subject: Re: New proposed DRM interface design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hamie <hamish@travellingkiwi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <413CCF79.2080407@travellingkiwi.com>
References: <20040904102914.B13149@infradead.org>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094398257.1251.25.camel@localhost.localdomain>
	 <9e47339104090514122ca3240a@mail.gmail.com>
	 <1094417612.1936.5.camel@localhost.localdomain>
	 <9e4733910409051511148d74f0@mail.gmail.com>
	 <1094425142.2125.2.camel@localhost.localdomain>
	 <413CCF79.2080407@travellingkiwi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094501705.4531.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Sep 2004 21:15:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-06 at 21:58, Hamie wrote:
> The fs -> SCSI interface is a logical one.

We just have to make the fb and DRI to hardware one logical.

> Unless you can have fb sitting on top of DRM of course... (I discount 
> DRM on-top of fb, because of the D == Direct... No other reason :)...
> 
> Does it make sens to have fb ontop of DRM at all? Anyone?

In some cases yes. The DRM is happy with the idea of the kernel being a
DRM client too.

