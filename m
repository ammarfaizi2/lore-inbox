Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161335AbWI2Uun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161335AbWI2Uun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWI2Uun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:50:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46472 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932379AbWI2Uum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:50:42 -0400
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC MAP_PRIVATE mmaps
From: Arjan van de Ven <arjan@infradead.org>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <efhtke$h5d$2@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru>
	 <Pine.LNX.4.64.0609272045560.24191@blonde.wat.veritas.com>
	 <451B5096.6020205@aknet.ru>
	 <Pine.LNX.4.64.0609281707190.27484@blonde.wat.veritas.com>
	 <efhtke$h5d$2@taverner.cs.berkeley.edu>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 29 Sep 2006 22:50:12 +0200
Message-Id: <1159563016.3093.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 01:41 +0000, David Wagner wrote:

> 9) Stas's request is a request for a change to Linux kernel semantics.
> The current mmap() semantics have been there for years.  We're not talking
> about some recent change to mmap() semantics that have broken existing
> userspace tools.  Rather, we have a longstanding set of semantics; Stas
> wants to be able to mark more partitions as noexec,


.... and then execute from them!
that's what is bothering me most about all of this.


