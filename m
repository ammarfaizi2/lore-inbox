Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSCFXHx>; Wed, 6 Mar 2002 18:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSCFXHo>; Wed, 6 Mar 2002 18:07:44 -0500
Received: from mout1.freenet.de ([194.97.50.132]:426 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S284264AbSCFXHb> convert rfc822-to-8bit;
	Wed, 6 Mar 2002 18:07:31 -0500
Date: Thu, 7 Mar 2002 00:06:54 +0100
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Subject: Known error compiling 2.5.6-pre2: In function `i810_dma_initialize'
Message-ID: <20020306230654.GA2658@prester.hh59.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo!

Kernel 2.5.6-pre2 has stopped compiling with i810 DRM enabled.

drivers/char/drm/drm.o: In function '810_dma_initialize':
drivers/char/drm/drm.o(.text+0x9305): undefined reference to
irt_to_bus_not_defined_use_pci_map'
make: *** [vmlinux] Error 1

I have kind of seen people talking about that on the list but haven´t found
a proper solution/patch to that yet. Can you please guide me to what to do?
I´m not that guy of a kernel hacker but like to try out 2.5 kernels.

Thank you very much in advance,
Axel Siebenwirth
