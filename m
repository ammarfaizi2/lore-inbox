Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVDLOtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVDLOtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVDLOtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:49:21 -0400
Received: from verein.lst.de ([213.95.11.210]:26277 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262346AbVDLOr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:47:28 -0400
Date: Tue, 12 Apr 2005 16:47:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] genalloc for 2.6.12-rc-mm3
Message-ID: <20050412144720.GA19894@lst.de>
References: <16987.39669.285075.730484@jaguar.mkp.net> <20050412031502.3b5d39fc.akpm@osdl.org> <yq0br8k12nd.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0br8k12nd.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <asm/pal.h>

this will break on all plattforms except alpha and ia64.

