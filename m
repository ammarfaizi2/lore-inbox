Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWDXOJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWDXOJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWDXOJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:09:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:57765 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750840AbWDXOJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:09:06 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Date: Mon, 24 Apr 2006 16:09:02 +0200
User-Agent: KMail/1.9.1
Cc: Joshua Brindle <method@gentoo.org>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <200604241526.03127.ak@suse.de> <1145886783.29648.39.camel@localhost.localdomain>
In-Reply-To: <1145886783.29648.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604241609.02565.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 April 2006 15:52, Alan Cox wrote:

> There is a much simpler answer anyway, sit in a loop trying to
> open /etc/shadow~ and wait for someone to change password. All the
> problems about names remain because of links anyway.

AFAIK AA avoids this problem by only allowing access to files, not forbidding 
access. So unless you put /etc/shadow~ (or /etc/*) into the profile
this cannot happen.

Instead you would list the files that application is allowed to access.

-Andi
