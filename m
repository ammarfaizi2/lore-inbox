Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUFQMSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUFQMSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUFQMSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:18:52 -0400
Received: from [213.146.154.40] ([213.146.154.40]:41898 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266469AbUFQMSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:18:50 -0400
Date: Thu, 17 Jun 2004 13:18:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040617121847.GA30894@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
References: <20040527210447.GA2029@elte.hu> <C7C4545F11DFBEindou.takao@soft.fujitsu.com> <20040617121356.GA24338@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617121356.GA24338@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, now that we got you in the loop, any chance to see a forward-port
of netdump to 2.6?  I think diskdump and netdump could share a lot of
infrastructure, and given we already have the net polling hooks adding
netdump shouldn't be that much work anymore.
