Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVAEQfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVAEQfr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVAEQdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:33:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63128 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262493AbVAEQdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:33:17 -0500
Date: Wed, 5 Jan 2005 16:33:14 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-bk8 fails compile -- drivers/video/fbmem.c
Message-ID: <20050105163314.GI26051@parcelfarce.linux.theplanet.co.uk>
References: <200501051600.j05G0WhT023481@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501051600.j05G0WhT023481@clem.clem-digital.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 11:00:32AM -0500, Pete Clements wrote:
> fyi:
> 
>   CC      drivers/video/fbmem.o
> drivers/video/fbmem.c: In function `fb_set_var':
> drivers/video/fbmem.c:719: parse error before `int'
> make[2]: *** [drivers/video/fbmem.o] Error 1

Move that declaration one line up...
