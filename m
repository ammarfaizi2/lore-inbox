Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754591AbWKHRHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbWKHRHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754593AbWKHRHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:07:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41645 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754591AbWKHRHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:07:11 -0500
Date: Wed, 8 Nov 2006 17:07:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, Martin.Weber@cern.ch, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at include/linux/dcache.h:303
Message-ID: <20061108170709.GA30221@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Martin.Weber@cern.ch,
	linux-kernel@vger.kernel.org
References: <200611081708.43932.Martin.Weber@cern.ch> <20061108161232.GA19284@infradead.org> <E1GhqOq-0001MA-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GhqOq-0001MA-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 05:35:40PM +0100, Miklos Szeredi wrote:
> > Whatever propritary module shfs is it's most likely the cause.
> > Please try again without it.
> 
> While not propritary, shfs _is_ severely broken.  Try sshfs instead
> which provides similar functionality:
> 
>   http://fuse.sourceforge.net/sshfs.html

Agreed to that recommendation.  But then again either shfs is so outdated
that it doesn't even have a MODULE_LICENSE state or the submitter snipped
away a module without a proper license from the oops report..

