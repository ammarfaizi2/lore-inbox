Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVHBMjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVHBMjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVHBMgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:36:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40364 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261500AbVHBMft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:35:49 -0400
Date: Tue, 2 Aug 2005 13:35:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Mark Haverkamp <markh@osdl.org>,
       Christoph Hellwig <hch@lst.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latest Adaptec AACRAID driver doesn't compile on latest kernel
Message-ID: <20050802123543.GA10912@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Drab <drab@kepler.fjfi.cvut.cz>,
	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
	Mark Haverkamp <markh@osdl.org>, Christoph Hellwig <hch@lst.de>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <60807403EABEB443939A5A7AA8A7458B01792C1A@otce2k01.adaptec.com> <Pine.LNX.4.60.0508021359050.5060@kepler.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0508021359050.5060@kepler.fjfi.cvut.cz>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 02:31:55PM +0200, Martin Drab wrote:
> Hmm. I see. So perhaps you may ask someone (James, Christoph, ...?) to 
> revert that patch, because the scsi_cmnd->state is needed here for this 
> purpose.

Not, it's not.  Use of that field wouldn't have passed review.
