Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVJEQtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVJEQtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVJEQtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:49:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30602 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030248AbVJEQtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:49:32 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.63.0510051241580.23070@excalibur.intercode> 
References: <Pine.LNX.4.63.0510051241580.23070@excalibur.intercode>  <29942.1128529714@warthog.cambridge.redhat.com> 
To: James Morris <jmorris@namei.org>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 05 Oct 2005 17:48:09 +0100
Message-ID: <30441.1128530889@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > Key management access control through LSM is enabled by
> > CONFIG_SECURITY_KEYS.
> 
> Any reason why this is configurable?

Well, I saw that the network stuff was. I can make it non-configurable.

> Why wouldn't someone want this?

Speed/latency? But I suppose that's not really a factor.

What about the security ops for keys that I've made available? Does doing it
that way seem reasonable?

David
