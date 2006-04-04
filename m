Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWDDKYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWDDKYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 06:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWDDKYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 06:24:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8086 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751837AbWDDKYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 06:24:11 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060404095529.31311.3892.stgit@warthog.cambridge.redhat.com> 
References: <20060404095529.31311.3892.stgit@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH] Keys: Improve usage of memory barriers and remove IRQ disablement 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 04 Apr 2006 11:23:59 +0100
Message-ID: <31870.1144146239@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> The attached patch adds a missing memory barrier into the key_put() and
> removes an unnecessary barrier from install_session_keyring().
> ...

Signed-Off-By: David Howells <dhowells@redhat.com>
