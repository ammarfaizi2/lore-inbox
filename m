Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVJGJD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVJGJD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVJGJD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:03:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932096AbVJGJDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:03:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0510061204040.26937@excalibur.intercode> 
References: <Pine.LNX.4.63.0510061204040.26937@excalibur.intercode>  <Pine.LNX.4.63.0510061014540.26656@excalibur.intercode> <Pine.LNX.4.63.0510060404141.25593@excalibur.intercode> <29942.1128529714@warthog.cambridge.redhat.com> <23641.1128596760@warthog.cambridge.redhat.com> <30054.1128611494@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 10:03:36 +0100
Message-ID: <21699.1128675816@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > > > Should I expand the permissions mask to include a setattr?
> > > 
> > > Possibly for setperm and chown.
> > 
> > For setperm?
> 
> It changes an attribute of a key, for which you have DAC checks, therefore 
> you could assume that we'd also want MAC checks.

Does it matter that you can take away your own permission to change the
permissions?

David
