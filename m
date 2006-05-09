Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWEINQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWEINQC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWEINQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:16:01 -0400
Received: from verein.lst.de ([213.95.11.210]:8399 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750997AbWEINQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:16:01 -0400
Date: Tue, 9 May 2006 15:15:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
Message-ID: <20060509131547.GA8449@lst.de>
References: <4450A196.2050901@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4450A196.2050901@de.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/interrupt.h>
> +#include <asm/atomic.h>
> +#include <asm/types.h>

Please don't use <asm/types.h> directly ever.  Always include
<linux/types.h>

