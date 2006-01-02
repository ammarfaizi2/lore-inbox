Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWABQWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWABQWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWABQWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:22:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18920 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750805AbWABQWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:22:36 -0500
Date: Mon, 2 Jan 2006 16:22:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Lee Revell <rlrevell@joe-job.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
Message-ID: <20060102162229.GB13904@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Lee Revell <rlrevell@joe-job.com>,
	Bryan O'Sullivan <bos@pathscale.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <rlrevell@joe-job.com> <1135884385.6804.0.camel@mindpipe> <200601021605.k02G5iN9010252@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601021605.k02G5iN9010252@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 01:05:43PM -0300, Horst von Brand wrote:
> > > Problem with that is that if everybody and Aunt Tillie does the same,
> > > the kernel as a whole gets to be a mess. 
> 
> > ALSA does the exact same thing for the exact same reason.  Maybe an
> > indication that the kernel's i2c layer is too heavy?
> 
> That would mean that the respective teams should put their heads together
> and (re)design it to their needs...

Exactly.  We got quite a few developers to help adjusting the i2c stack
for their needs and improve it.  The i2c stack started out beeing used only
for hardware monitoring chips and then later multimedia devices.  Help to
make it more useful for other users is always appreciated.
