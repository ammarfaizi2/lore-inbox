Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265265AbUETUR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUETUR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 16:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUETUR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 16:17:56 -0400
Received: from palrel13.hp.com ([156.153.255.238]:14739 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265265AbUETURz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 16:17:55 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16557.4709.694265.314748@napali.hpl.hp.com>
Date: Thu, 20 May 2004 13:17:41 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
In-Reply-To: <20040520203532.A11902@infradead.org>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
	<16556.19979.951743.994128@napali.hpl.hp.com>
	<20040519234106.52b6db78.davem@redhat.com>
	<16556.65456.624986.552865@napali.hpl.hp.com>
	<20040520120645.3accf048.akpm@osdl.org>
	<16557.1651.307484.282000@napali.hpl.hp.com>
	<20040520203532.A11902@infradead.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 20 May 2004 20:35:32 +0100, Christoph Hellwig <hch@infradead.org> said:

  Christoph> IMHO this is exactly the wrong way around.  It should be
  Christoph> __ARCH_WANT_* or something like that so new architectures
  Christoph> don't carry the old garbage around by default.  There's
  Christoph> far too many new architectures keeping old syscalls by
  Christoph> accident.

Feel free to do that.  I was trying not to break anything and I'm
_certain_ I would have gotten it wrong if I had reversed the sense.

I think the current patch is an improvement, so unless someone comes
up with something better, I'd like to see it applied.

	--david
