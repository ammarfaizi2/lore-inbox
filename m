Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVLFSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVLFSnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVLFSnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:43:11 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:42163 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S965009AbVLFSnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:43:10 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4394696B.6060008@didntduck.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>
	 <20051206030828.GA823@opteron.random>  <4394696B.6060008@didntduck.org>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 18:42:55 +0000
Message-Id: <1133894575.4136.171.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 11:23 -0500, Brian Gerst wrote:
> Intel?  That's all nice and dandy if and only if you have an Intel
> CPU.   Not an option for AMD users, for obvious reasons.

Actually even the Intel support isn't particularly good. We don't have
proper mode setup code -- we have to invoke the BIOS to do mode setup,
and we can't set specific modelines (like PAL-compatible modes); we're
limited to what the BIOS knows about -- it's like vesafb with
acceleration.

There's some work on reverse-engineering the BIOS so that you can
hackishly poke 'new' modes into its tables, but it's still not a very
good option.

-- 
dwmw2


