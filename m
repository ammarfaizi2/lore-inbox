Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTGMXsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270457AbTGMXsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:48:52 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:22144 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S270452AbTGMXss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:48:48 -0400
Date: Mon, 14 Jul 2003 02:03:24 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: Jamie Lokier <jamie@shareable.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030714000324.GA29094@verdi.et.tudelft.nl>
References: <20030711140219.GB16433@suse.de> <20030712152406.GA9521@mail.jlokier.co.uk> <3F103018.6020008@pobox.com> <20030712112722.55f80b60.akpm@osdl.org> <20030712183929.GA10450@mail.jlokier.co.uk> <3F105B9A.7070803@pobox.com> <20030712193401.GD10450@mail.jlokier.co.uk> <3F1063AD.40206@pobox.com> <20030712194624.GF10450@mail.jlokier.co.uk> <20030713085118.V4482@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713085118.V4482@schatzie.adilger.int>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 08:51:18AM -0700, Andreas Dilger wrote:
> ext3 in 2.4 kernels does not support O_DIRECT.  To confuse matters,
> recent RH kernels silently ignore O_DIRECT if you are not root, so
> you may think O_DIRECT is being used, but it isn't.

Modern RH kernels also ignore O_DIRECT if you are root: O_DIRECT is
completely disabled/ignored.

I suspect it is because gcc-3.2.2-5 (in RH9) does not compile 2.4
O_DIRECT correctly ..

	greetings,
	Rob van Nieuwkerk
