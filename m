Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVEaUI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVEaUI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVEaUFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:05:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61714 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261395AbVEaUBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:01:44 -0400
Date: Tue, 31 May 2005 21:01:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Gerd Knorr <kraxel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
Message-ID: <20050531210136.B28353@flint.arm.linux.org.uk>
Mail-Followup-To: Timur Tabi <timur.tabi@ammasso.com>,
	Gerd Knorr <kraxel@suse.de>, linux-kernel@vger.kernel.org
References: <4297746C.10900@ammasso.com> <873bs5yrxj.fsf@bytesex.org> <429C87FF.5070003@ammasso.com> <20050531161345.GB24106@bytesex> <429CB429.8090008@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <429CB429.8090008@ammasso.com>; from timur.tabi@ammasso.com on Tue, May 31, 2005 at 01:59:53PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 01:59:53PM -0500, Timur Tabi wrote:
> I still haven't gotten an answer to my question about whether
> pgd/pud/pmd/pte_offset will obtain the physical address for a
> kmalloc'd buffer.

No it won't.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
