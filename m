Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267231AbUG1P3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUG1P3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUG1P3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:29:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:31437 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S267231AbUG1P3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:29:42 -0400
Date: Wed, 28 Jul 2004 08:29:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040728152938.GM10891@smtp.west.cox.net>
References: <20040728112222.GA7670@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728112222.GA7670@suse.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 01:22:22PM +0200, Olaf Hering wrote:

> The ppc bootloader code will not compile with zlib debug enabled.
> printf was not defined. Tested with vmlinux.coff
> This patch was sent out earlier. Appearently it is not possible
> to use the generic zlib copy in linux/lib
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

Again, I do not want to see this.  First, have you run into an occasion
where this was needed and helpful?  Second, I would much rather see
someone just rip out zlib.c and replace it with lib/zlib_deflate than to
try and modify the code again.

-- 
Tom Rini
http://gate.crashing.org/~trini/
