Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTBKU1O>; Tue, 11 Feb 2003 15:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTBKU1O>; Tue, 11 Feb 2003 15:27:14 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:23048 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266038AbTBKU1N>; Tue, 11 Feb 2003 15:27:13 -0500
Date: Tue, 11 Feb 2003 20:36:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       ISHIKAWA Mutsumi <ishikawa@linux.or.jp>, jejb@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 aic79xx] aic79xx build and lun detect problem fix
Message-ID: <20030211203658.A20596@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	ISHIKAWA Mutsumi <ishikawa@linux.or.jp>, jejb@steeleye.com,
	linux-kernel@vger.kernel.org
References: <20030211182558.DED278DC14@master.hanzubon.jp> <3729142704.1044994000@aslan.btc.adaptec.com> <20030211202112.A20082@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030211202112.A20082@infradead.org>; from hch@infradead.org on Tue, Feb 11, 2003 at 08:21:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 08:21:12PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 11, 2003 at 01:06:41PM -0700, Justin T. Gibbs wrote:
> > >  This patch will fix two problems.
> > > 
> > >   fix build problem related scsi_cmnd changes
> > 
> > The aic7xxx driver has one place that missed the conversion too.
> > Since the cmd->lun field is no longer filled in, why hasn't the
> > field been removed from the cmd structure?  That would make it
> > easy to catch these kinds of bugs.
> 
> I don't think that was intentional.  I'll submit a patch to remove it ASAP.

Actually it is already gone.

