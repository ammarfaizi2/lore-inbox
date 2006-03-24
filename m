Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWCXOgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWCXOgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWCXOgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:36:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:47817 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751495AbWCXOgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:36:54 -0500
To: "Stone Wang" <pwstone@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced mlock-LRU semantic
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 24 Mar 2006 15:36:46 +0100
In-Reply-To: <bc56f2f0603200535s2b801775m@mail.gmail.com>
Message-ID: <p73bqvv6ha9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stone Wang" <pwstone@gmail.com> writes:
>    mlocked areas.
> 2. More consistent LRU semantics in Memory Management.
>    Mlocked pages is placed on a separate LRU list: Wired List.

If it's mlocked why don't you just called it Mlocked list? 
Strange jargon makes the patch cooler? Also in meminfo

-Andi
