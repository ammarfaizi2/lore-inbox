Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbUCTOtW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUCTOtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:49:22 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:10230 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263427AbUCTOtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:49:21 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fast 64-bit atomic writes (SSE?)
References: <874qskl5ca.fsf@love-shack.home.digitalvampire.org.suse.lists.linux.kernel>
	<p73znacvuic.fsf@brahms.suse.de>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@digitalvampire.org>
Date: 20 Mar 2004 06:48:37 -0800
In-Reply-To: <p73znacvuic.fsf@brahms.suse.de>
Message-ID: <87vfkzk20q.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> Better is probably to use CMPXCHG8, which avoids all of
    Andi> this.

Sorry to follow up again so soon, but I just looked up CMPXCHG8, and I
don't see how to use it to write to write-only device memory.  Can you
elaborate a little?

Thanks,
  Roland
