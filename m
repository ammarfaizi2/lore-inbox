Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVDRQsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVDRQsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVDRQsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:48:54 -0400
Received: from webmail.topspin.com ([12.162.17.3]:55985 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262133AbVDRQsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:48:06 -0400
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Troy Benjegerdes <hozer@hozed.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<4263DBBF.9040801@ammasso.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 18 Apr 2005 09:12:45 -0700
In-Reply-To: <4263DBBF.9040801@ammasso.com> (Timur Tabi's message of "Mon,
 18 Apr 2005 11:09:35 -0500")
Message-ID: <52is2kawsi.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 Apr 2005 16:12:45.0549 (UTC) FILETIME=[74E9C1D0:01C54431]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timur> Why do you call mlock() and get_user_pages()?  In our code,
    Timur> we only call mlock(), and the memory is pinned.  We have a
    Timur> test case that fails if only get_user_pages() is called,
    Timur> but it passes if only mlock() is called.

What if a buggy/malicious userspace program doesn't call mlock()?

 - R.
