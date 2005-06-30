Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVF3LPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVF3LPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVF3LPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:15:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:42419 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262540AbVF3LNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:13:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: chris@zankel.net
Subject: Re: xtensa-cleanups-for-errno-and-ipc.patch added to -mm tree
Date: Thu, 30 Jun 2005 13:07:59 +0200
User-Agent: KMail/1.7.2
Cc: sfr@canb.auug.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200506300113.j5U1DxLH013112@shell0.pdx.osdl.net>
In-Reply-To: <200506300113.j5U1DxLH013112@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200506301308.00186.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 30 Juni 2005 03:13, akpm@osdl.org wrote:

> From: Chris Zankel <chris@zankel.net>
>
> I noticed this because I was doing some more ipc cleanups and I did the
> original errno and ipc cleanups for other architectures, so it stuck out.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Chris Zankel <chris@zankel.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Actually, it would be better not to have sys_ipc or include/asm-xtensa/ipc.h
at all but rather have all ipc syscalls as separate entry points.

IIRC, parisc is the only architecture to get this right so far, so please
have a look there.

	Arnd <><
