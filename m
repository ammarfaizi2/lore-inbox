Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUBRUvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUBRUvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:51:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:34951 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268073AbUBRUvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:51:17 -0500
Date: Wed, 18 Feb 2004 12:52:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brandon Low <lostlogic@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-Id: <20040218125227.0bf7dc2f.akpm@osdl.org>
In-Reply-To: <20040218203325.GC449@lostlogicx.com>
References: <20040217232130.61667965.akpm@osdl.org>
	<40338FE8.60809@tmr.com>
	<20040218200439.GB449@lostlogicx.com>
	<20040218122216.62bb9e82.akpm@osdl.org>
	<20040218203325.GC449@lostlogicx.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brandon Low <lostlogic@gentoo.org> wrote:
>
> but if people are depending on that support to stay
>  in a stable kernel and are developing based on it and don't have the
>  time to learn dm or dmcrypto and redesign whatever may need redesigning
>  to use it, it strikes me as rude to pull that support.

This is actually an argument for removing cryptolooop.  People are
developing against a crypto infrastructure which has well-known weaknesses.

Pulling it out is an excellent way of communicating this fact.  Right now,
we're just deluding people.

