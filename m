Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWBASMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWBASMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBASMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:12:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48354 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932448AbWBASMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:12:42 -0500
Date: Wed, 1 Feb 2006 18:12:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] s390: avoid usage of 'new' in header files.
Message-ID: <20060201181238.GB18464@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060201115832.GB9361@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201115832.GB9361@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 12:58:32PM +0100, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Don't use 'new' as name for variables, since some C++ sources may include
> these header files.

NACK.  Userspace must not include these headers ever, and C++ in the kernel is not
supported.

