Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423002AbWBBGEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423002AbWBBGEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWBBGEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:04:32 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:53951 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423002AbWBBGEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:04:31 -0500
Date: Thu, 2 Feb 2006 07:04:18 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] s390: avoid usage of 'new' in header files.
Message-ID: <20060202060418.GA9366@osiris.boeblingen.de.ibm.com>
References: <20060201115832.GB9361@osiris.boeblingen.de.ibm.com> <20060201181238.GB18464@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201181238.GB18464@infradead.org>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 06:12:38PM +0000, Christoph Hellwig wrote:
> On Wed, Feb 01, 2006 at 12:58:32PM +0100, Heiko Carstens wrote:
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > Don't use 'new' as name for variables, since some C++ sources may include
> > these header files.
> 
> NACK.  Userspace must not include these headers ever, and C++ in the kernel is not
> supported.

Agreed.

Thanks,
Heiko
