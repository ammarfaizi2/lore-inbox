Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTDCUQh 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263369AbTDCUQf 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:16:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52358
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263510AbTDCUPT 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:15:19 -0500
Subject: Re: RAID 5 performance problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan van Hienen <raid@a2000.nu>
Cc: "Peter L. Ashford" <ashford@sdsc.edu>,
       Jonathan Vardy <jonathan@explainerdc.com>, linux-raid@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0304032104070.3085@ddx.a2000.nu>
References: <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu>
	 <Pine.LNX.4.53.0304032104070.3085@ddx.a2000.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049398084.11742.88.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Apr 2003 20:28:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-03 at 20:20, Stephan van Hienen wrote:
> > 2.  I/O bandwidth (multiple PCI buses)
> sure this helps, but he is not even getting near the pci bus
> limitations...

With mirrored software raid you are writing twice the data over
the PCI bus.

