Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266761AbUGLImi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266761AbUGLImi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUGLImi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:42:38 -0400
Received: from holomorphy.com ([207.189.100.168]:10381 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266761AbUGLImh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:42:37 -0400
Date: Mon, 12 Jul 2004 01:42:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <20040712084231.GX21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <20040712003418.02997a12.akpm@osdl.org> <1089620980.2806.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089620980.2806.8.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 09:34, Andrew Morton wrote:
>> so if need_resched() stays false then this will hold the lock for a long
>> time and bogus reports are generated:

On Mon, Jul 12, 2004 at 10:29:40AM +0200, Arjan van de Ven wrote:
> ... or reset the time(r) in need_resched() under the assumption that all
> need_resched() callers will yield when it returns true...

Might be a good enough approximation. Two examples and a counterexample...


-- wli
