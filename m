Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWHaHIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWHaHIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWHaHIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:08:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751009AbWHaHIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:08:53 -0400
Date: Thu, 31 Aug 2006 00:08:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: ak@muc.de, torvalds@osdl.org
Subject: Re: + x86-rwlock-fix.patch added to -mm tree
Message-Id: <20060831000848.9237a1a7.akpm@osdl.org>
In-Reply-To: <200608310643.k7V6hrux027748@shell0.pdx.osdl.net>
References: <200608310643.k7V6hrux027748@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 23:43:53 -0700
akpm@osdl.org wrote:

> Subject: x86: rwlock.h fix
> From: Andrew Morton <akpm@osdl.org>
> 
> It compiles.  Don't know if it works yet.

Nope, instant lockup during "Locking API testsuite".  Mainline is presently 100%
busted on x86 SMP.
