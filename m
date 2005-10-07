Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbVJGSgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbVJGSgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 14:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030523AbVJGSgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 14:36:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030527AbVJGSgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 14:36:24 -0400
Date: Fri, 7 Oct 2005 11:36:05 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management
Message-ID: <20051007183605.GR16352@shell0.pdx.osdl.net>
References: <Pine.LNX.4.63.0510061148250.26937@excalibur.intercode> <Pine.LNX.4.63.0510061053180.26758@excalibur.intercode> <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode> <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net> <23333.1128596048@warthog.cambridge.redhat.com> <30209.1128611882@warthog.cambridge.redhat.com> <21406.1128675035@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21406.1128675035@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> James Morris <jmorris@namei.org> wrote:
> 
> > Ok, time to add KEY_CREATE?
> 
> But to what? It is possible to request or create a key without linking it to
> anything, at least for kernel services.

I don't see the need.  Write permission to keyring, yes, link permission
to link a key to a keyring, yes.
