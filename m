Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUCAOiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUCAOiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:38:52 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:39692 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261303AbUCAOgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:36:08 -0500
Date: Mon, 1 Mar 2004 14:36:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Steven J. Hill" <Steve.Hill@timesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Make linux/swap.h usable by userspace code.
Message-ID: <20040301143606.A6460@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Steven J. Hill" <Steve.Hill@timesys.com>,
	linux-kernel@vger.kernel.org
References: <4043498F.7050101@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4043498F.7050101@timesys.com>; from Steve.Hill@timesys.com on Mon, Mar 01, 2004 at 09:32:47AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 09:32:47AM -0500, Steven J. Hill wrote:
> Greetings.
> 
> This patch allows 'swap.h' to be included by userspace code. AFAIK the
> LTP suite is the only code that does this so far.

Gack.  Including swap.h is really silly.  Fix ltp to not do such things
instead.

