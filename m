Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbUKKH2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUKKH2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbUKKH2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:28:19 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:3532 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S262180AbUKKH1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:27:42 -0500
Date: Thu, 11 Nov 2004 07:27:34 +0000
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.6.9
Message-ID: <20041111072734.GA1671@titan.home.hindley.uklinux.net>
References: <20041110074851.GA9757@titan.home.hindley.uklinux.net> <4191D13C.3060308@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4191D13C.3060308@yahoo.com.au>
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 07:28:44PM +1100, Nick Piggin wrote:
 
>    a9 40 00 00 00            test   $0x40,%eax
>    74 08                     je     33 <_EIP+0x33>
>    0f 0b                     ud2a
> 
> So eax (20001045) is page->flags, which is
> PG_locked | PG_referenced | PG_active | PG_private, I think.
> 
> You might have flipped a bit. Can you run memtest86 on the system overnight?
> 

Ran for 12 hours overnight. Extended tests, no errors.

M
