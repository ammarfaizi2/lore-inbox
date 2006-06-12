Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWFLJJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWFLJJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWFLJJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:09:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:61346 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750916AbWFLJJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:09:44 -0400
X-Authenticated: #428038
Date: Mon, 12 Jun 2006 11:09:32 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: David Miller <davem@davemloft.net>
Cc: rlrevell@joe-job.com, folkert@vanheusden.com, matti.aarnio@zmailer.org,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060612090932.GF11649@merlin.emma.line.org>
Mail-Followup-To: David Miller <davem@davemloft.net>, rlrevell@joe-job.com,
	folkert@vanheusden.com, matti.aarnio@zmailer.org,
	linux-kernel@vger.kernel.org
References: <20060610222734.GZ27502@mea-ext.zmailer.org> <20060611160243.GH20700@vanheusden.com> <1150048497.14253.140.camel@mindpipe> <20060611.115430.112290058.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060611.115430.112290058.davem@davemloft.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Bcc'ing David Relson to protect his mail address from the usual vger
flamewars.)

On Sun, 11 Jun 2006, David Miller wrote:

> To be honest I'm all for some kind of bayesian filter at vger as long
> as the rejected postings go somewhere into a folder I can scan every
> couple of days looking for false positives.

I suggest to try out bogofilter and spamprobe. Either lets YOU decide
what to do with its finding if it's spam or ham. bogofilter or spamprobe
works together with some filter like procmail or maildrop and you code
what happens with message that is "Spam", "Ham" or "Unsure", and you can
even look at the numeric value from 0 (ham) to 1 (spam) and decide. The
default install suggests an "unsure" range that you can also manually
look at.

Spamprobe also works rather well for many, although I don't know much
about its details today, haven't followed it for many months.

-- 
Matthias Andree
