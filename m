Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWD0L7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWD0L7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWD0L7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:59:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46757 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965030AbWD0L7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:59:21 -0400
Date: Thu, 27 Apr 2006 12:59:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Heiko J Schick <schihei@de.ibm.com>, openib-general@openib.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 03/16] ehca: structure definitions
Message-ID: <20060427115915.GA15520@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Heiko J Schick <schihei@de.ibm.com>, openib-general@openib.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
References: <4450A16D.7000008@de.ibm.com> <20060427115749.GD32127@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427115749.GD32127@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 01:57:49PM +0200, J?rn Engel wrote:
> On Thu, 27 April 2006 12:48:13 +0200, Heiko J Schick wrote:
> > +
> > +#ifdef CONFIG_PPC64
> > +#include "ehca_classes_pSeries.h"
> > +#endif
> 
> Is the #ifdef necessary?  Such conditions around header includes often
> indicate problems with the included header.  If that is the case here,
> you should fix the header in question in a seperate patch.

The real question is what is that ifdef for at all?  The code subitted
isn't built on anything but ppc64.

