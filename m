Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRK0Kv2>; Tue, 27 Nov 2001 05:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbRK0KvS>; Tue, 27 Nov 2001 05:51:18 -0500
Received: from ns.ithnet.com ([217.64.64.10]:21000 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S276761AbRK0KvN>;
	Tue, 27 Nov 2001 05:51:13 -0500
Date: Tue, 27 Nov 2001 11:51:03 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Didier Moens <moensd@xs4all.be>
Cc: rml@tech9.net, Nicolas.Aspert@epfl.ch, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
Message-Id: <20011127115103.2928bd15.skraw@ithnet.com>
In-Reply-To: <3C02BF41.1010303@xs4all.be>
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be>
	<3C022BB4.7080707@epfl.ch>
	<1006808870.817.0.camel@phantasy>
	<3C02BF41.1010303@xs4all.be>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001 23:16:33 +0100
Didier Moens <moensd@xs4all.be> wrote:

> Dear Robert, Nicolas, Stephan,   :)
> 
> I got two patches :
> 
> 
> 1. From Stephan, to test whether my assumption about the secondary 
> device was right :
> 
> Stephan wrote :
> 
> But if you want you can check that out pretty simple: just add a "break" 
> right
> after the case :
> 
>                  case PCI_DEVICE_ID_INTEL_830_M_0:
> ---> break;
> 
>                          i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
> 
> 
> This patch left me with a loaded agpgart, and accelerated X (DRM/DRI). 
> The acceleration is still not up to par with an ATI Mobility-128 (30% 
> lower, while it should be at least 200% faster), but I suspect an X 
> CVS-problem here.
> 
> Quitting and restarting X leaves me with a locked black screen.

Can you provide the output provided by the agp module at load time, please?
This mini-patch of mine should indeed be technically sufficient. Of course I
will provide a "real-world" patch working for all i830 agp-chipsets (M or MG)
as soon as it is clear, that the detection still works.
I am a bit bothered by your X setup. Can you stabilize this somehow? Maybe
using some known-to-work (older) X version for your graphics card.

It looks solvable.

Regards,
Stephan

