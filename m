Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbTDCUgH 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263558AbTDCUgH 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:36:07 -0500
Received: from p508B6582.dip.t-dialin.net ([80.139.101.130]:13187 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id S261386AbTDCUgG 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:36:06 -0500
Date: Thu, 3 Apr 2003 22:46:47 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, "David S. Miller" <davem@redhat.com>,
       Jes Sorensen <jes@trained-monkey.org>, Miles Bader <miles@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush flush_page_to_ram
Message-ID: <20030403224647.A8545@linux-mips.org>
References: <Pine.LNX.4.44.0304031741130.2047-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304031741130.2047-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Apr 03, 2003 at 05:47:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 05:47:55PM +0100, Hugh Dickins wrote:

> All architectures are updated, but the only ones where it amounts
> to more than deleting a line or two are m68k, mips, mips64 and v850.

As of about two weeks ago I've eleminated flush_page_to_ram() from the
MIPS code - it was indeed a huge patch ...

  Ralf
