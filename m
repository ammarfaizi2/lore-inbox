Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVASKbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVASKbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 05:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVASKbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 05:31:11 -0500
Received: from mx1.elte.hu ([157.181.1.137]:8417 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261655AbVASKbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 05:31:09 -0500
Date: Wed, 19 Jan 2005 11:30:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050119103020.GA4417@elte.hu>
References: <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E6BE6B.6050400@comcast.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Richard Moser <nigelenki@comcast.net> wrote:

> > There was a kernel-based randomization patch floating around at some 
> > point, though. I think it's part of PaX. That's the one I hated. 
> 
> PaX and Exec Shield both have them; personally I believe PaX is a more
> mature technology, since it's 1) still actively developed, and 2) been
> around since late 2000.  The rest of the community dissagrees with me
> of course, [...]

might this disagreement be based on the fact that exec-shield _is_ being
actively developed and is in active use in Fedora/RHEL, and that split
out portions of exec-shield (e.g. flexmmap, PT_GNU_STACK, NX) are
already in the upstream kernel?

(but no doubt PaX is fine and protects against exploits at least as
effectively as (and in some cases more effectively than) exec-shield, so
you've definitely not made a bad choice.)

	Ingo
