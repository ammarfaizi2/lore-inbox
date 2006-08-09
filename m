Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWHIIvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWHIIvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWHIIvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:51:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:28310 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965104AbWHIIvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:51:52 -0400
X-Authenticated: #428038
Date: Wed, 9 Aug 2006 10:51:49 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: jdow <jdow@earthlink.net>
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: Time to forbid non-subscribers from posting to the list?
Message-ID: <20060809085149.GB27939@merlin.emma.line.org>
Mail-Followup-To: jdow <jdow@earthlink.net>, davids@webmaster.com,
	linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKIECNNKAB.davids@webmaster.com> <04b101c6bb33$9131bd00$0225a8c0@Wednesday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b101c6bb33$9131bd00$0225a8c0@Wednesday>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-08-09)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2006, jdow wrote:

> If you have the luxury of the ability to write personalized rules and
> whitelist entries for SpamAssassin it can become a startlingly good
> filtering system. And you can tailor the filtering for individual 
> sources with meta rules. Processing large numbers of messages through
> BAYES and large numbers of rules gets quite time consuming, perhaps

Bayes and distributed filtering in SpamAssassin, although it integrates
nicely with the scoring, is so painfully slow that I've ditched it after
a short test drive. Systems such as bogofilter, spamprobe or qsf are way
faster - and can also look at tags that SpamAssassin (in local non-bayes
mode) may have added to the header.

-- 
Matthias Andree
