Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWCTNL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWCTNL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWCTNL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:11:29 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:48644 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751122AbWCTNL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:11:28 -0500
Date: Mon, 20 Mar 2006 13:10:53 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] [MIPS] Improve description of VR41xx based machines
Message-ID: <20060320131053.GA29434@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com> <20060320043902.GA20416@deprecation.cyrius.com> <20060320152646.1c5690e3.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320152646.1c5690e3.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2006-03-20 15:26]:
> > MIPS supports various NEC VR41XX chips and not just the VR4100.
> > Update Kconfig accordingly, thereby bringing the file in sync with
> > the linux-mips tree.
> The linux-mips tree is older than kernel.org about this part.

Have you looked at the exact change I sent (I know that linux-mips has
some older stuff, but the patch I sent was against linux-mips+new).
IOW, is it more correct to say "VR4100" in Kconfig rather than
"VR41XX", even though more CPUs than the VR4100 are supported?

All my patch does is a a/VR4100/VR41XX/, really.


> > -	bool "Support for NEC VR4100 series based machines"
> > +	bool "Support for NEC VR41XX-based machines"
...
> > -	  The options selects support for the NEC VR4100 series of processors.
> > +	  The options selects support for the NEC VR41xx series of processors.
> >  	  Only choose this option if you have one of these processors as a

-- 
Martin Michlmayr
http://www.cyrius.com/
