Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267295AbUHIVgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267295AbUHIVgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267302AbUHIV2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:28:20 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:52493 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267232AbUHIV2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:28:01 -0400
Date: Mon, 9 Aug 2004 22:27:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, bjorn.helgaas@hp.com, akpm@osdl.org,
       ehm@cris.com, grif@cs.ucr.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Message-ID: <20040809222746.A10650@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, bjorn.helgaas@hp.com,
	akpm@osdl.org, ehm@cris.com, grif@cs.ucr.edu,
	linux-kernel@vger.kernel.org
References: <200408091252.58547.bjorn.helgaas@hp.com> <20040809210335.A9711@infradead.org> <20040809141155.0c94b8c4.davem@redhat.com> <20040809221529.A10454@infradead.org> <20040809142012.23dc22af.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040809142012.23dc22af.davem@redhat.com>; from davem@redhat.com on Mon, Aug 09, 2004 at 02:20:12PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 02:20:12PM -0700, David S. Miller wrote:
> > It's called CONFIG_DEVFS.  disable this config option (it's marked OBSOLETE anyway)
> > and your device names are the same.
> 
> I wish to do 2.4.x and 2.6.x development on the same system.
> Is this such a foreign concept for you?

In 2.4 devfs was even more broken.   In fact it's whole scsi naming scheme is
complete bullshit, and you're now complaining because of that.  That has absolutely
nothing to do with 2.4 vs 2.6.
