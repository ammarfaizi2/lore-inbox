Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTBURq4>; Fri, 21 Feb 2003 12:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbTBURqz>; Fri, 21 Feb 2003 12:46:55 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:48651 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267612AbTBURqz>; Fri, 21 Feb 2003 12:46:55 -0500
Date: Fri, 21 Feb 2003 17:57:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] cli() for net/atm/lec.c
Message-ID: <20030221175702.A4224@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	chas williams <chas@locutus.cmf.nrl.navy.mil>, davem@redhat.com,
	linux-kernel@vger.kernel.org
References: <200302201751.h1KHpKqA009567@locutus.cmf.nrl.navy.mil> <200302211740.h1LHecGi014946@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302211740.h1LHecGi014946@locutus.cmf.nrl.navy.mil>; from chas@locutus.cmf.nrl.navy.mil on Fri, Feb 21, 2003 at 12:40:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -634,6 +635,7 @@
>          dev->get_stats = lec_get_stats;
>          dev->set_multicast_list = NULL;
>          dev->do_ioctl  = NULL;
> +	spin_lock_init(&lec_arp_spinlock);

This is still superflous..

