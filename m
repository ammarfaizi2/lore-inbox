Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWFLIby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWFLIby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWFLIby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:31:54 -0400
Received: from ns.firmix.at ([62.141.48.66]:8862 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750875AbWFLIbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:31:53 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Bernd Petrovitsch <bernd@firmix.at>
To: marty fouts <mf.danger@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <9f7850090606101924r32947e69vb6a34fe905227ff4@mail.gmail.com>
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
	 <1149980791.18635.197.camel@shinybook.infradead.org>
	 <9f7850090606101924r32947e69vb6a34fe905227ff4@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 12 Jun 2006 10:27:23 +0200
Message-Id: <1150100843.26402.22.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.331 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 19:24 -0700, marty fouts wrote:
[...]
> Further, while there is an RFC for SPF, it is an RFC for an
> experimental protocol. In addition to what David points out in his web
> site, SPF is controversial, and is in competition with other
> approaches.  (See RFC 4408.)

Not really: http://new.openspf.org/SPF_vs_Sender_ID

> It's not widely deployed.

However "widely deployed" is defined.
It is more widely deployed than any remotely similar proposed mechanism
(including and especially SenderId - which addresses actually another
problem).

> It doesn't work.

It works if it is used correctly (as any tool in the world).
The "problem" is that postmasters on the Net must do something (namely
1) define if they want to allow others to detect forged emails claimed
to come from their domain and 2) - if yes to 1) - to get appropriate SPF
records into DNS) and people must either use a "good" mail relay (and
not just the one next door) or convince postmasters to change the SPF
records.

> It'll break standard-abiding email.

As you see, standards change.

> Do you really want that?

Yes. Especially gmail.com should do such a thing - there is such a lot
of - presumbly forged - @gmail.com mails in my mailboxes that
blacklisting the whole domain causes probably more good than bad (for
me, of course).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

