Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTBKULb>; Tue, 11 Feb 2003 15:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTBKULb>; Tue, 11 Feb 2003 15:11:31 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:14856 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265998AbTBKULa>; Tue, 11 Feb 2003 15:11:30 -0500
Date: Tue, 11 Feb 2003 20:21:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: ISHIKAWA Mutsumi <ishikawa@linux.or.jp>, jejb@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 aic79xx] aic79xx build and lun detect problem fix
Message-ID: <20030211202112.A20082@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	ISHIKAWA Mutsumi <ishikawa@linux.or.jp>, jejb@steeleye.com,
	linux-kernel@vger.kernel.org
References: <20030211182558.DED278DC14@master.hanzubon.jp> <3729142704.1044994000@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3729142704.1044994000@aslan.btc.adaptec.com>; from gibbs@scsiguy.com on Tue, Feb 11, 2003 at 01:06:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 01:06:41PM -0700, Justin T. Gibbs wrote:
> >  This patch will fix two problems.
> > 
> >   fix build problem related scsi_cmnd changes
> 
> The aic7xxx driver has one place that missed the conversion too.
> Since the cmd->lun field is no longer filled in, why hasn't the
> field been removed from the cmd structure?  That would make it
> easy to catch these kinds of bugs.

I don't think that was intentional.  I'll submit a patch to remove it ASAP.

