Return-Path: <linux-kernel-owner+w=401wt.eu-S1750735AbXACMh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbXACMh2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 07:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbXACMh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 07:37:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35293 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750735AbXACMh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 07:37:27 -0500
Date: Wed, 3 Jan 2007 12:44:10 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       torvalds@osdl.org, 76306.1226@compuserve.com, akpm@osdl.org,
       bunk@stusta.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
Message-ID: <20070103124410.4cb191dd@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
	<20070103102944.09e81786@localhost.localdomain>
	<Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > fixed. At that point an i686 kernel would contain i686 instructions and
> > actually run on all i686 processors ending all the i586 pain for most
> > users and distributions.
> 
> Could you explain why CMOV is pointless now? Are there any benchmarks 
> proving that?

Take a look at the recent ffmpeg bits on the mplayer list for one example
I have to hand - P4 cmov is pretty slow. The crypto folks find the same
things.

Alan

