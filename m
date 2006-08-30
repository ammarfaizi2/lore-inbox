Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWH3PFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWH3PFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWH3PFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:05:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750949AbWH3PFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:05:42 -0400
Date: Wed, 30 Aug 2006 08:05:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/2] NOMMU: Set BDI capabilities for /dev/mem and
 /dev/kmem
Message-Id: <20060830080518.155c9d59.akpm@osdl.org>
In-Reply-To: <19020.1156927122@warthog.cambridge.redhat.com>
References: <20060829122851.690e5219.akpm@osdl.org>
	<20060829112030.a2a8c763.akpm@osdl.org>
	<20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com>
	<1082.1156876794@warthog.cambridge.redhat.com>
	<19020.1156927122@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 09:38:42 +0100
David Howells <dhowells@redhat.com> wrote:

> > Or you could use the approach I suggested, like wot everyone else does.
> 
> Ummm...  I don't recall ever coming across a construct like that in the
> kernel.

box:/usr/src/linux-2.6.18-rc5> grep -r '^#define.*suspend[      ]*NULL' . | wc -l
75

We do it to reduce (and to localise) ifdefs.
