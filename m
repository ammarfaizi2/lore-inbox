Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWDXN0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWDXN0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWDXN0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:26:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59807 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750778AbWDXN0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:26:22 -0400
From: Andi Kleen <ak@suse.de>
To: Joshua Brindle <method@gentoo.org>
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Date: Mon, 24 Apr 2006 15:26:02 +0200
User-Agent: KMail/1.9.1
Cc: Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17484.20906.122444.964025@cse.unsw.edu.au> <444CCE83.90704@gentoo.org>
In-Reply-To: <444CCE83.90704@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604241526.03127.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 April 2006 15:11, Joshua Brindle wrote:

> Sure but if, instead, it's able to open /var/chroot/etc/shadow which is 
> a hardlink to /etc/shadow you've bought nothing. You may filter out 
> worms and script kiddies this way but in the end you are using obscurity 
> (of filesystem layout, what the policy allows, how the apps are 
> configured, etc) for security, which again, leads to a false sense of 
> security.

AppArmor disallows both chroot and name space changes for the constrained
application so the scenario you're describing cannot happen. What happens
with unconstrained applications it doesn't care about by design.

This has been covered several times in this thread already - please pay
more attention.

-Andi

