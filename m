Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbUK3Ap6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUK3Ap6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUK3Ap6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:45:58 -0500
Received: from hera.kernel.org ([63.209.29.2]:48003 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261906AbUK3Apx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:45:53 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Tue, 30 Nov 2004 00:45:47 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cogfrr$371$1@terminus.zytor.com>
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1101775547 3298 127.0.0.1 (30 Nov 2004 00:45:47 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 30 Nov 2004 00:45:47 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
> 
> If glibc wants to do something new, go wild. The kernel won't care.
> 
> And that's really the fundamental issue. The kernel does not care what
> user land does. The kernel exports functionality, the kernel does _not_
> ask user land to help.
> 
> That _does_ make it a one-way street. Sorry.
> 

And it SHOULD be a one-way street.  A lot of the ugliness in the
current stuff comes from the fact that the kernel tries to export
libc4/5 internals, instead of the real kernel ABI.

	-hpa
