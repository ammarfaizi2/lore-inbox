Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261885AbTDBHH3>; Wed, 2 Apr 2003 02:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTDBHH3>; Wed, 2 Apr 2003 02:07:29 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:52747 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261885AbTDBHH2>; Wed, 2 Apr 2003 02:07:28 -0500
Date: Wed, 2 Apr 2003 08:18:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] second pass at fixing atm spinlock
Message-ID: <20030402081847.A22335@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <200303272228.h2RMSSGi009141@locutus.cmf.nrl.navy.mil> <200304011628.h31GSXGi000846@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304011628.h31GSXGi000846@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Tue, Apr 01, 2003 at 11:28:33AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 11:28:33AM -0500, chas williams wrote:
> >ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_64_atm_dev_lock.patch
> 
> i have made an equivalent version of these patches for 2.4.20 in hopes
> of getting more feedback.
> 
> ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_4_20_atm_dev_lock.patch
> 
> (only the nicstar, fore200e, eni and he (included) driver support the
> new smp 'safe' locking)

You always include the he driver in your patches, what about cleaning it up
and submitting it first?

