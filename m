Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265736AbUGEJYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUGEJYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 05:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUGEJYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 05:24:31 -0400
Received: from [213.146.154.40] ([213.146.154.40]:46809 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265736AbUGEJYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 05:24:30 -0400
Date: Mon, 5 Jul 2004 10:24:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 0/22] fsaio, pipe aio and aio poll upgraded to 2.6.7
Message-ID: <20040705092426.GA14404@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org, linux-osdl@osdl.org
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> Its been a while since I last posted the retry based AIO patches
> that I've been accumulating. Janet Morgan recently brought
> the whole patchset up-to to 2.6.7.
> 
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).

Any chance you could re-arrange the patchkit into logical patches instead
of just adding incremental fixes, aka merge all the fixes into their respective
base-patches?

