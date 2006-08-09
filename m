Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbWHILW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbWHILW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030690AbWHILW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:22:58 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:42211 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1030633AbWHILW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:22:57 -0400
Date: Wed, 9 Aug 2006 13:22:55 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: jdow <jdow@earthlink.net>, davids@webmaster.com,
       linux-kernel@vger.kernel.org
Subject: Re: Time to forbid non-subscribers from posting to the list?
Message-ID: <20060809112255.GC4373@harddisk-recovery.com>
References: <MDEHLPKNGKAHNMBLJOLKIECNNKAB.davids@webmaster.com> <04b101c6bb33$9131bd00$0225a8c0@Wednesday> <20060809085149.GB27939@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809085149.GB27939@merlin.emma.line.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 10:51:49AM +0200, Matthias Andree wrote:
> Bayes and distributed filtering in SpamAssassin, although it integrates
> nicely with the scoring, is so painfully slow that I've ditched it after
> a short test drive. Systems such as bogofilter, spamprobe or qsf are way
> faster - and can also look at tags that SpamAssassin (in local non-bayes
> mode) may have added to the header.

Spamassassin is slow if you call it at every message cause the Perl
startup and init is quite expensive. If you run the spamassassin daemon
(spamd) and use the spamassassin client (spamc) it's a lot faster.

Over here it can cope with lots of mailing list traffic and even more
spam (>30000 messages a day on an Athlon 2400+).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
