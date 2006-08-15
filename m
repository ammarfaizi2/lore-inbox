Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWHOStp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWHOStp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWHOStp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:49:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965123AbWHOSto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:49:44 -0400
Date: Tue, 15 Aug 2006 11:49:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060815114912.d8fa1512.akpm@osdl.org>
In-Reply-To: <6241.1155666920@warthog.cambridge.redhat.com>
References: <20060815104813.7e3a0f98.akpm@osdl.org>
	<20060815065035.648be867.akpm@osdl.org>
	<20060814143110.f62bfb01.akpm@osdl.org>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<20060813012454.f1d52189.akpm@osdl.org>
	<10791.1155580339@warthog.cambridge.redhat.com>
	<918.1155635513@warthog.cambridge.redhat.com>
	<29717.1155662998@warthog.cambridge.redhat.com>
	<6241.1155666920@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 19:35:20 +0100
David Howells <dhowells@redhat.com> wrote:

> > SELinux: initialized (dev 0:15, type nfs), uses genfs_contexts
> 
> I wonder if this is something to do with it.

`echo 0 > /selinux/enforce' "fixes" it.
