Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVBFOsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVBFOsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVBFOsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:48:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20396 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261168AbVBFOsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:48:13 -0500
Date: Sun, 6 Feb 2005 14:48:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Message-ID: <20050206144804.GA834@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com> <1107682076.22680.58.camel@laptopd505.fenrus.org> <58cb370e050206044513eb7f89@mail.gmail.com> <42062BFE.7070907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42062BFE.7070907@pobox.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 09:38:54AM -0500, Jeff Garzik wrote:
> Without device mapper (another new feature) to enable dmraid, these 
> users are just sorta S.O.L.
> 
> I consider it not a new feature, but a missing feature, since otherwise 
> user data cannot be accessed in the RAID setups.

So those people should switch to Linux 2.6, or simply avoid using one
of the various softraid variants for the data they want to share with
windows.  Both Linux (md or dm) and Windows (LDM) can mirror individual
partitions just fine.

