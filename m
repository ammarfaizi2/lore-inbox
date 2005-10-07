Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVJGIvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVJGIvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 04:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVJGIu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 04:50:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10157 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932104AbVJGIu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 04:50:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0510061148250.26937@excalibur.intercode> 
References: <Pine.LNX.4.63.0510061148250.26937@excalibur.intercode>  <Pine.LNX.4.63.0510061053180.26758@excalibur.intercode> <Pine.LNX.4.63.0510060346140.25593@excalibur.intercode> <29942.1128529714@warthog.cambridge.redhat.com> <20051005211030.GC16352@shell0.pdx.osdl.net> <23333.1128596048@warthog.cambridge.redhat.com> <30209.1128611882@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 09:50:35 +0100
Message-ID: <21406.1128675035@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > The permissions check done on the keyring merely assures that the keyring
> > can be modified, not that a new key may or may not actually be created.
> 
> Ok, time to add KEY_CREATE?

But to what? It is possible to request or create a key without linking it to
anything, at least for kernel services.

David
