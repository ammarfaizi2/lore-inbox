Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUFNITj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUFNITj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUFNITR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:19:17 -0400
Received: from [213.146.154.40] ([213.146.154.40]:27601 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262114AbUFNIQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:16:40 -0400
Date: Mon, 14 Jun 2004 09:16:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [12/12] fix thread_info.h ignoring __HAVE_THREAD_FUNCTIONS
Message-ID: <20040614081639.GI7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com> <20040614004354.GX1444@holomorphy.com> <20040614004516.GY1444@holomorphy.com> <20040614004701.GZ1444@holomorphy.com> <20040614004855.GA1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004855.GA1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:48:55PM -0700, William Lee Irwin III wrote:
>  * Check __HAVE_THREAD_FUNCTIONS in include/linux/thread_info.h (m68k)
> This fixes the build on m68k; its thread_info functions need to be used.

I don't like this one a lot and prefer to discuss it with the m68k folks
first.  Given they didn't sent it to Linus themselves I guess they're not
completely proud of it ;-)

