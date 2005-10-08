Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVJHK3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVJHK3K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 06:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVJHK3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 06:29:10 -0400
Received: from mx1.suse.de ([195.135.220.2]:45777 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750892AbVJHK3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 06:29:08 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH][Fix] swsusp: avoid possible page tables corruption during resume on x86-64
Date: Sat, 8 Oct 2005 12:30:55 +0200
User-Agent: KMail/1.8
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200510011813.54755.rjw@sisk.pl> <20051005224959.GB22781@elf.ucw.cz> <200510061007.45698.rjw@sisk.pl>
In-Reply-To: <200510061007.45698.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081230.55656.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I reworked the patch a bit to do on demand page table setup. Does it still 
work for you? 

-Andi

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/suspend-pgtables
