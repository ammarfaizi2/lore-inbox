Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264828AbUDWOho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbUDWOho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbUDWOhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:37:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264828AbUDWOhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:37:42 -0400
Date: Fri, 23 Apr 2004 11:39:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marek Mentel <mmark@ichpw.zabrze.pl>
Cc: kern <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed  - kernel 2.4.24
Message-ID: <20040423143909.GC21104@logos.cnet>
References: <4088C094.2060904@ichpw.zabrze.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4088C094.2060904@ichpw.zabrze.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 09:07:00AM +0200, Marek Mentel wrote:
> 
> Is this  just out-of-memory situation or  more serious bug ?
> 
> Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1d2/0)
> Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1d2/0)
> Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1f0/0)
> Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1d2/0)
> Apr 22 10:42:18 koala kernel: VM: killing process named
> Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed 
> (gfp=0x1d2/0)
> Apr 22 10:42:18 koala kernel: VM: killing process sendmail

Just out of memory (and out of swap).
