Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbUCGStP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 13:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbUCGStP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 13:49:15 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:32018 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262302AbUCGStO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 13:49:14 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-pre2
References: <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 07 Mar 2004 10:49:05 -0800
In-Reply-To: <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl>
Message-ID: <52y8qcv6fy.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Mar 2004 18:49:05.0792 (UTC) FILETIME=[DDD90000:01C40474]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Eyal> In standard C we declare all variables at the top of a
    Eyal> function. While some compilers allow extension, it is not a
    Eyal> good idea to get used to them if we want portable code.

    Horst> Oh, come on. This is _kernel_ code, it won't ever be
    Horst> compiled with anything not GCC-compatible.

gcc 2.95 rejects declarations after code.  The kernel, especially
kernel 2.4, shouldn't use this particular extension, even if gcc 3
accepts it.

 - R.

