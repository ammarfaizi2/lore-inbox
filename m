Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbUK2S1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUK2S1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUK2S1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:27:48 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:12443 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261469AbUK2S1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:27:39 -0500
Subject: Re: MTRR vesafb and wrong X performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041129181718.GA16782@redhat.com>
References: <1101338139.1780.9.camel@PC3.dom.pl>
	 <20041124171805.0586a5a1.akpm@osdl.org>
	 <1101419803.1764.23.camel@PC3.dom.pl> <87is7ogb93.fsf@bytesex.org>
	 <20041129154006.GB3898@redhat.com> <20041129162242.GA25668@bytesex>
	 <20041129165701.GA903@redhat.com> <20041129173419.GC26190@bytesex>
	 <20041129181718.GA16782@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101749036.21211.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 17:23:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-29 at 18:17, Dave Jones wrote:
> Even that wasn't foolproof however, and there were a few quirks
> to work around still.  You see all sorts of strange things there,
> like onboard gfx with 16MB advertising 64MB prefetchable ranges.

Thats normal rather than a quirk. You've got big and little endian
apertures. You may have dithering depth apertures, YUV convertor
apertures and so on.

