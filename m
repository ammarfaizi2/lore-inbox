Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWDKWC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWDKWC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDKWC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:02:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751133AbWDKWC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:02:58 -0400
Date: Tue, 11 Apr 2006 15:05:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use atomic ops for file_nr accounting, not spinlock+irq
Message-Id: <20060411150512.5dd6e83d.akpm@osdl.org>
In-Reply-To: <16476.1144773375@warthog.cambridge.redhat.com>
References: <16476.1144773375@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Make the kernel use atomic operations for files_stat.nr_files accounting
> rather than using a spinlocked and interrupt-disabled critical section.

This code has all been redone in current kernels.
