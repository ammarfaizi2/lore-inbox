Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVEROpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVEROpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVEROcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:32:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62181 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262239AbVERO1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:27:40 -0400
Date: Wed, 18 May 2005 15:27:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: cotte@freenet.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 1/5] bdev: execute in place (V2)
Message-ID: <20050518142739.GB23162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, cotte@freenet.de,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	schwidefsky@de.ibm.com, akpm@osdl.org
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424403.2202.16.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116424403.2202.16.camel@cotte.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	int (*direct_access) (struct inode *, sector_t, unsigned long *);

this should have a block_device * first argument.

