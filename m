Return-Path: <linux-kernel-owner+w=401wt.eu-S1750707AbXACKcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbXACKcJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 05:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbXACKcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 05:32:09 -0500
Received: from alpha.polcom.net ([83.143.162.52]:55766 "EHLO alpha.polcom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbXACKcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 05:32:08 -0500
Date: Wed, 3 Jan 2007 11:32:00 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       torvalds@osdl.org, 76306.1226@compuserve.com, akpm@osdl.org,
       bunk@stusta.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <20070103102944.09e81786@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <20070103102944.09e81786@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Alan wrote:
> The proper fix for all of this mess is to fix the gcc compiler suite to
> actually generate i686 code when told to use i686. CMOV is an optional
> i686 extension which gcc uses without checking. In early PIV days it made
> sense but on modern processors CMOV is so pointless the bug should be
> fixed. At that point an i686 kernel would contain i686 instructions and
> actually run on all i686 processors ending all the i586 pain for most
> users and distributions.

Could you explain why CMOV is pointless now? Are there any benchmarks 
proving that?


Thanks,

Grzegorz Kulewski

