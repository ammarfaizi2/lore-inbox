Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbSJQQsI>; Thu, 17 Oct 2002 12:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSJQQsI>; Thu, 17 Oct 2002 12:48:08 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:24326 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261717AbSJQQsH>; Thu, 17 Oct 2002 12:48:07 -0400
Date: Thu, 17 Oct 2002 17:54:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make LSM register functions GPLonly exports
Message-ID: <20021017175403.A32516@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Crispin Cowan <crispin@wirex.com>, Greg KH <greg@kroah.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20021017153505.A27998@infradead.org> <20021017150740.GA31056@kroah.com> <3DAEEA7A.6000803@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAEEA7A.6000803@wirex.com>; from crispin@wirex.com on Thu, Oct 17, 2002 at 09:51:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 09:51:06AM -0700, Crispin Cowan wrote:
> My argument against the intent of this change is that no, I do not think 
> we should restrict LSM modules to be GPL-only. LSM is an API for loading 
> externally developed packages of software, similar to syscalls. There is 
> benefit in permitting proprietary modules (you get additional modules 
> that you would not get otherwise) just as there is benefit in permitting 
> proprietary applications (you get Oracle, DB2, and WordPerfect).

My arguement is that I want this flag as a hint for authors of
propritary security modules that I'm going to sue them if they
use hook called from code I have copyright on.  This includes such
central parts as vfs_read/vfs_write.

> no legal standing what so ever. If kernel module interfaces are held by 
> a court to be linking, then export symbols are redundant. If kernel 
> module interfaces are held by a court to be an interface, then the 
> export symbols are just wrong.

It's a very clear hint, and very usefull as such.

