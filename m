Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269179AbUJKTQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269179AbUJKTQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUJKTQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:16:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39612 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269179AbUJKTQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:16:36 -0400
Date: Mon, 11 Oct 2004 15:16:03 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: __init dependencies (was: Re: [PATCH] find_isa_irq_pin can't be )__init
Message-ID: <20041011191603.GH23303@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20041010225717.GA27705@redhat.com> <Pine.GSO.4.61.0410111333260.19312@waterleaf.sonytel.be> <20041011121225.2f829507.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011121225.2f829507.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 12:12:25PM -0700, Andrew Morton wrote:
 > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
 > >
 > > I guess it's about time for a tool to autodetect __init dependencies?
 > 
 > `make buildcheck' does this.  Looks like nobody is using it.

Actually, aparently I goofed, and that patch is only needed in
our Fedora kernels.  It won't hurt in mainline though, and I'll
push the other bits after 2.6.9

		Dave

