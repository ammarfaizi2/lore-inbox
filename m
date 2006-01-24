Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWAXWjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWAXWjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWAXWjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:39:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21424 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750795AbWAXWjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:39:05 -0500
Date: Tue, 24 Jan 2006 17:38:34 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060124223834.GH2449@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	rjw@sisk.pl, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <20060124213010.GA1602@elf.ucw.cz> <20060124135843.739481e7.akpm@osdl.org> <20060124221426.GB1602@elf.ucw.cz> <20060124222044.GG2449@redhat.com> <20060124223328.GC1602@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124223328.GC1602@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > We'll of course try to get the interface right at the first
 > try. OTOH... if wrong interface is in kernel for a month, I do not
 > think it is reasonable to keep supporting that wrong interface for a
 > year before it can be removed. One month of warning should be fair in
 > such case...

Users want to be able to boot between different kernels.
Tying functionality to specific versions of userspace completely
screws them over.

		Dave

