Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWH2Lv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWH2Lv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWH2Lv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:51:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61921 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964951AbWH2Lv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:51:56 -0400
Date: Tue, 29 Aug 2006 12:51:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060829115138.GA32714@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10117.1156522985@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 05:23:05PM +0100, David Howells wrote:
> > >  config USB_STORAGE
> > >  	tristate "USB Mass Storage support"
> > > -	depends on USB
> > > +	depends on USB && BLOCK
> > 
> > ditto.
> 
> ditto?

Same as above.  USB_STORAGE already selects scsi so it shouldn't need
to depend on block.

