Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757027AbWKVVUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757027AbWKVVUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757028AbWKVVUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:20:23 -0500
Received: from smtp.osdl.org ([65.172.181.25]:17602 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757005AbWKVVUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:20:22 -0500
Date: Wed, 22 Nov 2006 13:20:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] WorkStruct: Shrink work_struct by two thirds
Message-Id: <20061122132008.2691bd9d.akpm@osdl.org>
In-Reply-To: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
References: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 13:02:22 +0000
David Howells <dhowells@redhat.com> wrote:

> These patches shrink work_struct by 8 of the 12 words it ordinarily consumes.

waaaaaaaay too many rejects for me, sorry.  This is quite the worst time in the
kernel cycle to be preparing patches like this.  Especially when they're against
mainline when everyone has so much material pending.

Please wait until 2.6.20-rc1, or prepare diffs against next -mm.
