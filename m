Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267185AbUGVTnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUGVTnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUGVTmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:42:49 -0400
Received: from [213.146.154.40] ([213.146.154.40]:5357 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S267185AbUGVTmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:42:37 -0400
Date: Thu, 22 Jul 2004 20:42:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robin Holt <holt@sgi.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Pat Gefre <pfg@sgi.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code re-org
Message-ID: <20040722194231.GA16991@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robin Holt <holt@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200407221514.i6MFEVag084696@fsgi900.americas.sgi.com> <200407221357.53404.jbarnes@engr.sgi.com> <20040722192003.GA617@lnx-holt.americas.sgi.com> <20040722194050.GA797@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722194050.GA797@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PS:  I found a few small problems with the bte code and will soon have
> another patch that fixes that up.  Specifically, there were changes
> made to bte_error.c and pda.h that are undone by your patch.

apropos bte, could you please merge bte_error.c into bte.c - there's no
external callers of functions in bte_error.c except in bte.c

