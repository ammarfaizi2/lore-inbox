Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbVKBW2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbVKBW2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbVKBW2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:28:44 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:38443 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S965312AbVKBW2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:28:43 -0500
Date: Wed, 2 Nov 2005 23:31:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Roland Dreier <rolandd@cisco.com>, Andrew Morton <akpm@osdl.org>,
       zippel@linux-m68k.org, ak@suse.de, rmk+lkml@arm.linux.org.uk,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051102223108.GA20416@mars.ravnborg.org>
References: <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com> <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org> <52u0eva8yu.fsf@cisco.com> <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org> <52ll07a844.fsf@cisco.com> <Pine.LNX.4.64.0511020746330.27915@g5.osdl.org> <20051102174852.GB1899@redhat.com> <Pine.LNX.4.62.0511021207550.2820@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0511021207550.2820@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I used to compile with Os on all my kernels, but when the alignment 
> settings got added to the embedded section a few kernels ago and I saw 
> that they all default to 0 (no alignment) it scared me off

Alignment settings in the EMBEDDED menu are ignored if set to 0, in
other words setting alignment to 0 in Kconfig will fall back to
compilers default values.

Thats also documented in the help for the config options.

	Sam
