Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbVKCS5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbVKCS5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbVKCS5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:57:19 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:2109 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030442AbVKCS5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:57:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fIazgoh5ENP9Jdnt+RitM7v2jZVl2fdXW4aQHaKEw7zJXWnc/B2Y151FRBajjIRW2whxalRNJAQecB8xhmqBCsu64qNIbWLBV9mtTfCZl+r+g45XZ0BhEk9HDN+pv7gYBgOkwhNOvV5OZHaHJrgT2tT4Pi0LWCODt962043N0ts=
Date: Thu, 3 Nov 2005 22:10:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Krufky <mkrufky@m1k.net>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 04/37] dvb: Add ATSC support for DViCO FusionHDTV5 Lite
Message-ID: <20051103191024.GA7994@mipter.zuzino.mipt.ru>
References: <4367236E.90008@m1k.net> <20051103132914.64e971b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103132914.64e971b9.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 01:29:14PM +1100, Andrew Morton wrote:
> Michael Krufky <mkrufky@m1k.net> wrote:
> > +static int tdvs_tua6034_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
> >  +{
> >  +	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *) fe->dvb->priv;

[cast from void *]

Please, also

	struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
			   ^				       ^

