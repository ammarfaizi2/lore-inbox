Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUK0Dss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUK0Dss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUK0Ds3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:48:29 -0500
Received: from pauli.thundrix.ch ([213.239.201.101]:17281 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S262597AbUK0D36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 22:29:58 -0500
Date: Sat, 27 Nov 2004 05:29:42 +0100
From: Tonnerre <tonnerre@thundrix.ch>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, dwmw2@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041127042942.GA10774@pauli.thundrix.ch>
References: <19865.1101395592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19865.1101395592@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salut,

On Thu, Nov 25, 2004 at 03:13:12PM +0000, David Howells wrote:
> We've been discussing splitting the kernel headers into userspace API headers
> and kernel internal headers and deprecating the __KERNEL__ macro. This will
> permit a cleaner interface between the kernel and userspace; and one that's
> easier to keep up to date.

Fnord alert: you're trying to change the API and the ABI of Linux. The thing
you fail to see is that Linux is not the only operating system in the world. 
Big companies are very prone of using their compatibility code to make their
program run in any odd way they like without actually having to change
anything. Also, you're talking about assumptions that have been true for
decades.

Big companies are already eyeing Linux with fear because our kernels don't
actually work and because we break a lot of compatibility in the stable
series. If you now come up with something that breaks basically everything
so they need a new libc and everything, it's rather likely that they'll run
away.

I just want you to consider that. Linux needs to get to a stable state of
affairs at some time.

			    Tonnerre

