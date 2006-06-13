Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWFMMtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFMMtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWFMMtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:49:49 -0400
Received: from mail.gmx.de ([213.165.64.21]:52187 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750754AbWFMMts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:49:48 -0400
X-Authenticated: #428038
Date: Tue, 13 Jun 2006 14:49:44 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060613124944.GA16171@merlin.emma.line.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl> <1150189506.11159.93.camel@shinybook.infradead.org> <20060613104557.GA13597@merlin.emma.line.org> <1150201475.12423.12.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150201475.12423.12.camel@hades.cambridge.redhat.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cutting Cc list short)

On Tue, 13 Jun 2006, David Woodhouse wrote:

> > Given that list drivers are separate from the MTA (and that's good),
> 
> I'm unconvinced of the goodness of that.

Separating tasks into distinct processes, to prevent rampant list
drivers from messing with the MTA and vice versa.

I'm also not convinced greylisting is a "solution". Once it catches on,
spammers will retry. They control enough drones where smashing out
successful deliveries from their address list and retrying them will
work for them.

-- 
Matthias Andree
