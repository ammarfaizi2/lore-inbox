Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWDXIKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWDXIKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDXIKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:10:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:22190 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751132AbWDXIKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:10:42 -0400
Date: Mon, 24 Apr 2006 10:11:30 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Arjan van de Ven <arjan@infradead.org>, Neil Brown <neilb@suse.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060424081130.GF440@marowsky-bree.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au> <1145862899.3116.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145862899.3116.3.camel@laptopd505.fenrus.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-24T09:14:58, Arjan van de Ven <arjan@infradead.org> wrote:

> does apparmor at least (offer) to kill the app when this happens?
> (rationale: the app is hijacked, better kill it before it goes to do
> damage)

Heh, that was just my question to Crispin this morning, because that's
what I'd prefer too.

Not just for security, but simply because experience shows that error
paths are not well auditted in general; even if it doesn't cause
privilege escalation, I prefer if it doesn't shred the data it is
allowed to access by hitting a misconfiguration in my profile...



-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

