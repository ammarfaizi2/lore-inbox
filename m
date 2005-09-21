Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVIUShH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVIUShH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVIUShH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:37:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751361AbVIUShF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:37:05 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1127324834.11109.26.camel@lade.trondhjem.org> 
References: <1127324834.11109.26.camel@lade.trondhjem.org>  <5378.1127211442@warthog.cambridge.redhat.com> <12434.1127314090@warthog.cambridge.redhat.com> <20050921101558.7ad7e7d7.akpm@osdl.org> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add possessor permissions to keys 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 21 Sep 2005 19:36:58 +0100
Message-ID: <6325.1127327818@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> 
> Shouldn't that test for IS_ERR(key_ref) be inverted?

Yes, and it should come first.

David
