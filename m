Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbRFUNeQ>; Thu, 21 Jun 2001 09:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264961AbRFUNeG>; Thu, 21 Jun 2001 09:34:06 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:31929 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S264958AbRFUNd5>; Thu, 21 Jun 2001 09:33:57 -0400
Date: Thu, 21 Jun 2001 23:50:25 +1000
From: john slee <indigoid@higherplane.net>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
Message-ID: <20010621235025.J30872@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.10.10106211833390.3193032-100000@Sky.inp.nsk.su>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 06:38:09PM +0700, Dmitry A. Fedorov wrote:
> kernel module to delivery hardware interrupts to user space
> programs. Hardware interrupts (IRQ) are accessible by
> character devices /dev/irq[0-15]. Interrupts delivered by
> signals and select(2)/poll(2)

i believe libgpio uses the existing usb/iee1394/serial/parallel
interfaces to provide a limited userspace driver capability.  gphoto2
uses this to support a LOT of digital cameras entirely in userspace...

obviously this concept isn't covering everything but it sure covers a
lot of bases.  also depends on what you understand a "driver" to be...
from a "common user"'s perspective it just means "it makes my WinWidget
work!"

it's similar to what you describe above in that there's a kernel
interface, but it's more specific than /dev/irq5.  this is good in that
you don't want a different usb driver for every userspace usb device
driver...

http://sourceforge.net/projects/gphoto/ (i think)

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
