Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWJENov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWJENov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWJENov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:44:51 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:1873 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750918AbWJENov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:44:51 -0400
Date: Thu, 5 Oct 2006 15:45:21 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH] drivers/base: error handling fixes
Message-ID: <20061005154521.05157c17@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061005132006.GD6920@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org>
	<20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com>
	<20061005081705.GA6920@osiris.boeblingen.de.ibm.com>
	<4524E983.6010208@garzik.org>
	<20061005124848.GB6920@osiris.boeblingen.de.ibm.com>
	<20061005151546.31b73ab5@gondolin.boeblingen.de.ibm.com>
	<20061005132006.GD6920@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 15:20:06 +0200,
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> This is initcall stuff. The only sane reason why this would fail, would
> be an out of memory situation . If we are that early short on memory, we
> are in serious trouble anyway. So I doubt it's worth the extra code.

OK, at this stage -ENOMEM sounds like the only possiblilty. Agreed.
