Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVFOHCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVFOHCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 03:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFOHCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 03:02:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43483 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261166AbVFOHB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 03:01:57 -0400
Date: Wed, 15 Jun 2005 08:01:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Leroy Tennison <leroy_tennison@prodigy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is root=UUID=... a supported kernel parameter?
Message-ID: <20050615070153.GB15193@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Leroy Tennison <leroy_tennison@prodigy.net>,
	linux-kernel@vger.kernel.org
References: <42AFBAD7.2090607@prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AFBAD7.2090607@prodigy.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 12:21:27AM -0500, Leroy Tennison wrote:
> If yes, what is the correct format (I tried the above with the UUID 
> reported from dumpe2fs, didn't work).  If no, please consider as an 
> enhancement request.

No, it's not supported.  The kernel doesn't deal with UUIDs at all.
The initrd of various distributions support this feature, though.

