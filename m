Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUAPWdn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265895AbUAPWdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:33:43 -0500
Received: from magic.adaptec.com ([216.52.22.17]:3307 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S265890AbUAPWdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 17:33:42 -0500
Date: Fri, 16 Jan 2004 15:39:19 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stephen Smoogen <smoogen@lanl.gov>, linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
Message-ID: <2582475408.1074292759@aslan.btc.adaptec.com>
In-Reply-To: <1074289406.5752.5.camel@smoogen2.lanl.gov>
References: <1074289406.5752.5.camel@smoogen2.lanl.gov>
X-Mailer: Mulberry/3.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Booting problems with aic7xxx with stock kernel 2.4.24.

...

> Unexpected busfree while idle
> SEQ 0x01

A problem with similar symptoms was corrected in driver version 6.2.37
back in August of last year.  Can you try using the latest driver source
from here:

	http://people.FreeBSD.org/~gibbs/linux/SRC/

and see if your problem persists?  The aic79xx driver archive at the
above location includes both the aic7xxx and aic79xx drivers.  If this
does not resolve your problem there are other debugging options we can
enable that may aid in tracking down the problem.

--
Justin

