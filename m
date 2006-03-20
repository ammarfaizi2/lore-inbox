Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWCTNlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWCTNlX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWCTNlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:41:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964783AbWCTNlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:41:21 -0500
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and
	balanced mlock-LRU semantic
From: Arjan van de Ven <arjan@infradead.org>
To: Stone Wang <pwstone@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <bc56f2f0603200535s2b801775m@mail.gmail.com>
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 14:41:18 +0100
Message-Id: <1142862078.3114.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Posix mlock/munlock/mlockall/munlockall.
>    Get mlock/munlock/mlockall/munlockall to Posix definiton: transaction-like,
>    just as described in the manpage(2) of mlock/munlock/mlockall/munlockall.
>    Thus users of mlock system call series will always have an clear map of
>    mlocked areas.
> 2. More consistent LRU semantics in Memory Management.
>    Mlocked pages is placed on a separate LRU list: Wired List.

please give this a more logical name, such as mlocked list or pinned
list


