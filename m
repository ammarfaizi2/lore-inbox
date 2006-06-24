Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWFXNhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWFXNhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 09:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWFXNhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 09:37:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48363 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964836AbWFXNhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 09:37:11 -0400
Date: Sat, 24 Jun 2006 14:37:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
Message-ID: <20060624133703.GB15734@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Troy Benjegerdes <hozer@hozed.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20060624004154.GL5040@narn.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624004154.GL5040@narn.hozed.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 07:41:59PM -0500, Troy Benjegerdes wrote:
> This patch changes the in-kernel AFS client filesystem name to 'kafs',
> as well as allowing the AFS cache manager port to be set as a module
> parameter. This is usefull for having a system boot with the root
> filesystem on afs with the kernel AFS client, while still having the
> option of loading the OpenAFS kernel module for use as a read-write
> filesystem later.

NACK.  OpenAFS isn't even legal to load into the kernel, we shouldn't
support it.  Better help making the kernel afs client fully features
than wasting your time on this.

