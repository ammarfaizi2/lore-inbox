Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWDXHPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWDXHPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 03:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWDXHPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 03:15:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38822 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751012AbWDXHPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 03:15:45 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Brown <neilb@suse.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <17484.20906.122444.964025@cse.unsw.edu.au>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 09:14:58 +0200
Message-Id: <1145862899.3116.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A large part of the behaviour of an application is the path names that
> it uses and what it does with them.  If an application started doing
> unexpected things with unexpected paths (e.g. exec("/bin/sh") or
> open("/etc/shadow",O_RDONLY)) then this is a sure sign that it has
> been subverted and that AppArmor need to protect it, from itself.

does apparmor at least (offer) to kill the app when this happens?
(rationale: the app is hijacked, better kill it before it goes to do
damage)


