Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTLRBCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 20:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbTLRBCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 20:02:06 -0500
Received: from are.twiddle.net ([64.81.246.98]:39566 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S264889AbTLRBCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 20:02:04 -0500
Date: Wed, 17 Dec 2003 17:02:03 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha (2.6.0-test11)
Message-ID: <20031218010203.GA13385@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031213003841.GA5213@wang-fu.org> <20031217121010.GA11062@twiddle.net> <20031217193124.GA4837@wang-fu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217193124.GA4837@wang-fu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 01:31:24PM -0600, Nathan Poznick wrote:
> my next question is if this is a known/intended side effect -- enabling
> CONFIG_DEBUG_INFO means that modules cannot be used?

No.  This means there's a bug in the generic bits of the module
loaders, that they're not discarding debugging sections.


r~
