Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWFMJFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWFMJFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 05:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFMJFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 05:05:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750803AbWFMJFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 05:05:14 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: jdow <jdow@earthlink.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       nick@linicks.net, Bernd Petrovitsch <bernd@firmix.at>,
       marty fouts <mf.danger@gmail.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl>
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 10:05:06 +0100
Message-Id: <1150189506.11159.93.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 23:00 -0400, Horst von Brand wrote:
> > Greylist those who have not subscribed.
> 
> That is not easy to do. 

It's fairly trivial with a decent MTA. I use all kinds of conditions to
trigger greylisting -- HTML mail, 'Re:' in subject with no References:,
lack of reverse DNS or CSA on the sending host, >=0.1 SA points, etc.
Adding "is not subscribed to the mailing list they're trying to post to"
should be trivial.

-- 
dwmw2

