Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUJEQAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUJEQAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269093AbUJEPwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:52:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:43015 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269999AbUJEPvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:51:00 -0400
Date: Tue, 5 Oct 2004 16:50:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041005165046.A19870@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200410042157.i94Lv7UC104750@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200410042157.i94Lv7UC104750@fsgi900.americas.sgi.com>; from pfg@sgi.com on Mon, Oct 04, 2004 at 04:57:06PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also is there any chance you can move the additional rrb allocation for
the qlogic adapters into the prom so the driver doesn't have to bother
with it?  That way the whole SN_SAL_IOIF_RRB_ALLOC could go away.

