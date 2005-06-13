Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVFMJlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVFMJlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVFMJlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:41:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21162 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261447AbVFMJlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:41:53 -0400
Subject: Re: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       jnf <jnf@innocence-lost.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20050613091600.GA32364@outpost.ds9a.nl>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
	 <42AD2640.5040601@redhat.com>  <20050613091600.GA32364@outpost.ds9a.nl>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 10:41:41 +0100
Message-Id: <1118655702.2840.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 11:16 +0200, bert hubert wrote:
> So, please, consider merging the patches.. ppoll is something else, I never
> heard about it, but pselect is widely known.

It just seemed silly to implement pselect() without doing ppoll() at the
same time.

-- 
dwmw2

