Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbTIOOQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbTIOOQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:16:56 -0400
Received: from trained-monkey.org ([209.217.122.11]:3597 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S261356AbTIOOQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:16:55 -0400
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qla1280 & __flush_cache_all
References: <Pine.GSO.4.44.0309141410080.27187-100000@math.ut.ee>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 15 Sep 2003 10:16:52 -0400
In-Reply-To: <Pine.GSO.4.44.0309141410080.27187-100000@math.ut.ee>
Message-ID: <m33ceyi1bf.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Meelis" == Meelis Roos <mroos@linux.ee> writes:

Meelis> So why is qla1280 in 2.6-current using __flush_cache_all?

The driver is calling flush_cache_all() not __flush_cache_all(), the
__ thing is an architecture specific issue.

Yes it's a lazy approach left over from the old codebase.

Cheers,
Jes

