Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTDCRsf 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261440AbTDCRsf 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:48:35 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:24848 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S261427AbTDCRsb 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:48:31 -0500
Date: Thu, 3 Apr 2003 19:59:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@digeo.com>, "David S. Miller" <davem@redhat.com>,
       Jes Sorensen <jes@trained-monkey.org>, Ralf Baechle <ralf@gnu.org>,
       Miles Bader <miles@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] flush flush_page_to_ram
In-Reply-To: <Pine.LNX.4.44.0304031741130.2047-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304031948170.12110-100000@serv>
References: <Pine.LNX.4.44.0304031741130.2047-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 3 Apr 2003, Hugh Dickins wrote:

> I followed a prescription from DaveM (though not to the letter), that
> those arches with non-nop flush_page_to_ram need to do what it did
> in their clear_user_page and copy_user_page and flush_dcache_page.

I think flush_icache_page() has to be changed too.
Anyway, thanks for the patch, now I actually have to look into this 
seriously. :)

bye, Roman

