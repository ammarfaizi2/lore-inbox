Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267784AbUHEQmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267784AbUHEQmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUHEQmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:42:37 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:1292 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267784AbUHEQmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:42:35 -0400
Date: Thu, 5 Aug 2004 17:42:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-ID: <20040805174233.A1506@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>; from akpm@osdl.org on Thu, Aug 05, 2004 at 03:19:18AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +iteraid.patch
> +iteraid-cleanup.patch
> 
>  New ITE IT8212 RAID controller driver.  Still needs a bit of work before
>  handoff to the scsi guys to look at.

Just drop it.  It's not scsi hardware at all, and we have an ide driver for
that hardware already.
