Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVCGLYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVCGLYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVCGLYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:24:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261334AbVCGLYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:24:09 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050303123448.462c56cd.akpm@osdl.org> 
References: <20050303123448.462c56cd.akpm@osdl.org>  <20050302135146.2248c7e5.akpm@osdl.org> <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> <13767.1109857095@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Mon, 07 Mar 2005 11:23:44 +0000
Message-ID: <9268.1110194624@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> >  Making these into bitfields would result in having to use three variables
> >  instead of just the one.
> 
> Well let's do one or the other, and not have it half-and-half, please.

So I should fold the two other bitfields back into the capabilities mask and
make it an unsigned long.

David
