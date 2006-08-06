Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWHFRDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWHFRDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 13:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWHFRDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 13:03:09 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:21377 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750822AbWHFRDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 13:03:08 -0400
Date: Sun, 6 Aug 2006 19:02:05 +0200
From: Mattia Dongili <malattia@linux.it>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 [BUG at mm/vmscan.c:383!]
Message-ID: <20060806170205.GA3967@inferi.kami.home>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
	linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060806133306.GB4009@inferi.kami.home> <Pine.LNX.4.64.0608061545080.16384@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608061545080.16384@blonde.wat.veritas.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc3-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 03:55:43PM +0100, Hugh Dickins wrote:
> On Sun, 6 Aug 2006, Mattia Dongili wrote:
> > [  781.988000] kernel BUG at mm/vmscan.c:383!
> > [  781.988000] EIP is at remove_mapping+0xe8/0x120
> 
> You are so right: the minor fix below is needed.

Thanks now it runs ok (since ~30 minutes now).
Hot-fix? :)

-- 
mattia
:wq!
