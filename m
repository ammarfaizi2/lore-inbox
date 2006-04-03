Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWDCIkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWDCIkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWDCIkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:40:04 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:53973 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1750813AbWDCIkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:40:02 -0400
Date: Mon, 3 Apr 2006 01:44:10 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc1 core_sys_select incompatible pointer types
Message-ID: <20060403084410.GD3157@gaz.sfgoth.com>
References: <25355.1144052926@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25355.1144052926@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 03 Apr 2006 01:44:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 2.6.17-rc1, ia64, gcc 3.3.3
> 
> fs/select.c: In function `core_sys_select':
> fs/select.c:339: warning: assignment from incompatible pointer type
> fs/select.c:376: warning: comparison of distinct pointer types lacks a cast

I posted a patch to fix this and another problem with the recent select
changes a couple days ago.

Original version, with description:
  http://lkml.org/lkml/2006/3/31/308
Slightly updated:
  http://lkml.org/lkml/2006/3/31/316

I'm hoping that Andrew picked it up.  I'm waiting for the next -mm to see
if I need to agitate more :-)

-Mitch
