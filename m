Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVCNL5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVCNL5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVCNL5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:57:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37531 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261383AbVCNL5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:57:11 -0500
Date: Mon, 14 Mar 2005 11:57:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] uml-export-getgid-for-hostfs
Message-ID: <20050314115700.GA10692@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <20050311192753.043836477@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311192753.043836477@zion>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  EXPORT_SYMBOL_PROTO(getuid);
> +EXPORT_SYMBOL_PROTO(getgid);

please don't.  as mentioned in the discussion about ROOT_DEV the whole
code using it is bogus.

