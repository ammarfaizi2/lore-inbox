Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUIFABq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUIFABq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUIFABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:01:46 -0400
Received: from the-village.bc.nu ([81.2.110.252]:21663 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267352AbUIFABo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:01:44 -0400
Subject: Re: New proposed DRM interface design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <9e4733910409051511148d74f0@mail.gmail.com>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094425142.2125.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 23:59:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-05 at 23:11, Jon Smirl wrote:
> What is the advantage to continuing a development model where two
> groups of programmers work independently, with little coordination on
> two separate code bases trying to simultaneously control the same
> piece of hardware? This is a continuous source of problems. Why can't
> we fix the development model to stop this?

I don't see that as much of a problem. The mess arises from some simple
lacks in the objects in kernel and the methods required to co-ordinate.
Lots of drivers are written by a lot of people in the kernel and they
work just fine. The ext3 authors don't spend their lives co-ordinating
with SCSI driver authors, they just get the API right.

