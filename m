Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbVK3R3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbVK3R3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbVK3R3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:29:49 -0500
Received: from mail.tnnet.fi ([217.112.240.26]:29416 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S1751475AbVK3R3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:29:48 -0500
Message-ID: <438DE183.439170CD@users.sourceforge.net>
Date: Wed, 30 Nov 2005 19:29:39 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Arjan van de Ven <arjan@infradead.org>, Benjamin LaHaise <bcrl@kvack.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
References: <20051130042118.GA19112@kvack.org>	 <438D4905.9F023405@users.sourceforge.net> <1133337416.2825.18.camel@laptopd505.fenrus.org> <438D60B0.4020207@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Sounds like a trick question - I don't think the kernel does use any
> out-of-tree amd64 assember code, does it? ;)

Out-of-tree amd64 assember code is being run in kernel space. For example:
http://loop-aes.sourceforge.net/

Calling convention change that breaks existing assembler code that has been
field proven and is believed to be entirely free of bugs for long time, does
NOT belong in a STABLE kernel series.

OTOH, if your business model requires breaking stuff and then milking your
customers for "fixing" the breakage, then this type of change is
understandable.  </sarcasm>

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
