Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280609AbRKTVQX>; Tue, 20 Nov 2001 16:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280824AbRKTVQN>; Tue, 20 Nov 2001 16:16:13 -0500
Received: from [194.46.8.33] ([194.46.8.33]:54802 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S280609AbRKTVQE>;
	Tue, 20 Nov 2001 16:16:04 -0500
Date: Tue, 20 Nov 2001 21:20:55 +0000
From: Dale Amon <amon@vnl.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
Message-ID: <20011120212055.A22590@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011120190316.H19738@vnl.com> <Pine.LNX.3.95.1011120144925.14138A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1011120144925.14138A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 03:03:23PM -0500, Richard B. Johnson wrote:
> FYI, if you care about the name of your ethernet device, your
> configuration is probably broken. The IEEE station address can
> be used to identify a device and it's accessible from `ifconfig`
> without setting any network parameters. So, given this, you
> can set any number of boards found, to anything you need to
> configure, including complicated servers and routers, with a
> simple shell-script.

I presume IEEE station address == MAC...

I haven't really much choice. I can't use modules for
security reasons; I have to assign the motherboard MAC
to eth0 because a commercial package we are installing
licenses on the MAC address of eth0.  

Ifconfig cannot, to my knowledge, swap the identify of
eth0 and eth1. However I the iproute2 calls, if they are
available, might do the trick. I will have to see.

The only thing I really have control over is the kernel
itself, not the dist even.

Has the pci=reverse option been removed? That might
have done the trick.

Also, I don't really see anything inherently wrong with
being able to force some of these things at the boot
command line. 

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------
