Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSKCNHK>; Sun, 3 Nov 2002 08:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSKCNHK>; Sun, 3 Nov 2002 08:07:10 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:37125 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261839AbSKCNHK>; Sun, 3 Nov 2002 08:07:10 -0500
Date: Sun, 3 Nov 2002 13:13:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
Message-ID: <20021103131339.A22465@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200211031046.gA3AkmN2000902@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211031046.gA3AkmN2000902@callisto.of.borg>; from geert@linux-m68k.org on Sun, Nov 03, 2002 at 11:46:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 11:46:48AM +0100, Geert Uytterhoeven wrote:
> NCR53C9x ESP: C99 designated initializers

Please move the host template to the C file instead of the header
if you touch it.  Having them in the header and the methods exported
was needed in 2.2, but that's long ago..

