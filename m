Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUFNIK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUFNIK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUFNIK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:10:58 -0400
Received: from [213.146.154.40] ([213.146.154.40]:17361 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261654AbUFNIK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:10:58 -0400
Date: Mon, 14 Jun 2004 09:10:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [1/12] don't dereference netdev->name before register_netdev()
Message-ID: <20040614081056.GA7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003331.GP1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:33:31PM -0700, William Lee Irwin III wrote:
>  * Removed dev->name lookups before register_netdev
> This fixes Debian BTS #234817.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=234817

Herbert has worked with Jeff on this issue already.  And -netdev would
be the right list for it.

