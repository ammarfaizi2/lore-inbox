Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbTGNHyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270552AbTGNHyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:54:23 -0400
Received: from [81.2.110.254] ([81.2.110.254]:12793 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S265766AbTGNHyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:54:23 -0400
Subject: Re: 2.5 'what to expect'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: Jamie Lokier <jamie@shareable.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030714000324.GA29094@verdi.et.tudelft.nl>
References: <20030711140219.GB16433@suse.de>
	 <20030712152406.GA9521@mail.jlokier.co.uk> <3F103018.6020008@pobox.com>
	 <20030712112722.55f80b60.akpm@osdl.org>
	 <20030712183929.GA10450@mail.jlokier.co.uk> <3F105B9A.7070803@pobox.com>
	 <20030712193401.GD10450@mail.jlokier.co.uk> <3F1063AD.40206@pobox.com>
	 <20030712194624.GF10450@mail.jlokier.co.uk>
	 <20030713085118.V4482@schatzie.adilger.int>
	 <20030714000324.GA29094@verdi.et.tudelft.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058169566.561.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 09:01:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 01:03, Rob van Nieuwkerk wrote:
> On Sun, Jul 13, 2003 at 08:51:18AM -0700, Andreas Dilger wrote:
> > ext3 in 2.4 kernels does not support O_DIRECT.  To confuse matters,
> > recent RH kernels silently ignore O_DIRECT if you are not root, so
> > you may think O_DIRECT is being used, but it isn't.
> 
> Modern RH kernels also ignore O_DIRECT if you are root: O_DIRECT is
> completely disabled/ignored.
> 
> I suspect it is because gcc-3.2.2-5 (in RH9) does not compile 2.4
> O_DIRECT correctly ..

Wrong guess.

