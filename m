Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUDHSKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUDHSKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:10:17 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32433
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262135AbUDHSKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:10:13 -0400
Date: Thu, 8 Apr 2004 20:10:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rmap: nonlinear truncation
Message-ID: <20040408181011.GM31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081441480.7010-100000@localhost.localdomain> <20040408152830.GC31667@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408152830.GC31667@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not going to implement the proper nonlinaer truncation (to give more
strength to disable-cap-lock) until 14 Apr, so feel free to go ahead if
you want ;).

btw, thanks a lot for spotting the truncate vs nonlinear bug in
page_referenced too!
