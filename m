Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267522AbSLSBoI>; Wed, 18 Dec 2002 20:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267523AbSLSBoI>; Wed, 18 Dec 2002 20:44:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25834
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267522AbSLSBoH>; Wed, 18 Dec 2002 20:44:07 -0500
Subject: RE: 15000+ processes -- poor performance ?!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Till Immanuel Patzschke'" <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CACA2C@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA2C@orsmsx116.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Dec 2002 02:31:28 +0000
Message-Id: <1040265088.27221.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 01:04, Perez-Gonzalez, Inaky wrote:
> 
> > 
> > forgot the kernel version (2.4.20aa1)...
> 
> You need the O(1) scheduler; not sure if aa has it or not; if not, lots of
> processes will suck your machine. I think -ac has the O(1) scheduler, or try
> 2.5. The old scheduler is pretty cool but not as scalable as the new one.
> 
> If it has it ... well, I have no idea - maybe Robert Love would know.

He's running the -aa kernel, which has all the right bits for this too.
In fact in some ways for very large memory boxes its probably the better
variant

