Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267243AbUHIVSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267243AbUHIVSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUHIVRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:17:06 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:49933 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267251AbUHIVPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:15:43 -0400
Date: Mon, 9 Aug 2004 22:15:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, bjorn.helgaas@hp.com, akpm@osdl.org,
       ehm@cris.com, grif@cs.ucr.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] QLogic ISP2x00: remove needless busyloop
Message-ID: <20040809221529.A10454@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, bjorn.helgaas@hp.com,
	akpm@osdl.org, ehm@cris.com, grif@cs.ucr.edu,
	linux-kernel@vger.kernel.org
References: <200408091252.58547.bjorn.helgaas@hp.com> <20040809210335.A9711@infradead.org> <20040809141155.0c94b8c4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040809141155.0c94b8c4.davem@redhat.com>; from davem@redhat.com on Mon, Aug 09, 2004 at 02:11:55PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 02:11:55PM -0700, David S. Miller wrote:
> You could remove the qlogicfc driver if you really wanted, by providing
> a config option that would provide qlogicfc compatible device numbering
> in the qla2xxx driver.

It's called CONFIG_DEVFS.  disable this config option (it's marked OBSOLETE anyway)
and your device names are the same.

