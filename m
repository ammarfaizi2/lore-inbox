Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWD0GxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWD0GxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWD0GxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:53:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37853 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964970AbWD0GxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:53:01 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Ken Brush <kbrush@gmail.com>, Neil Brown <neilb@suse.de>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <200604270615.20554.ak@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <17487.61698.879132.891619@cse.unsw.edu.au>
	 <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
	 <200604270615.20554.ak@suse.de>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 08:52:51 +0200
Message-Id: <1146120771.2894.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 06:15 +0200, Andi Kleen wrote:
> On Thursday 27 April 2006 01:06, Ken Brush wrote:
> 
> > > 2/ What advantages does AppArmor provide over techniques involving
> > >    virtualisation or gaol mechanisms?  Are these advantages worth
> > >    while?
> 
> I would guess the advantage is easier administration. e.g. I always
> found it a PITA to synchronize files like /etc/resolv.conf and similar
> files into chroots.

there's another option than just chroots; construct a namespace with
just the allowed files bind-mounted in. That is 100% scriptable and also
doesn't have the "stale files" problem

