Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUFNIQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUFNIQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUFNIQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:16:00 -0400
Received: from [213.146.154.40] ([213.146.154.40]:26833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262103AbUFNIPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:15:32 -0400
Date: Mon, 14 Jun 2004 09:15:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [10/12] fix handling of '/' embedded in filenames in isofs
Message-ID: <20040614081531.GH7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com> <20040614004354.GX1444@holomorphy.com> <20040614004516.GY1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004516.GY1444@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:45:16PM -0700, William Lee Irwin III wrote:
>  * Fix slashes in broken Acorn ISO9660 images in fs/isofs/dir.c (Darren Salt)
> This fixes Debian BTS #141660.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=141660
> 
> 	From: Darren Salt <linux@youmustbejoking.demon.co.uk>
> 	Message-ID: <4B238BA09A%linux@youmustbejoking.demon.co.uk>
> 	To: submit@bugs.debian.org
> 	Subject: Handle '/' in filenames in broken ISO9660 images
> 
> [Also applicable to 2.2.x]
> 
> There has been for some time a problem with certain CD-ROMs whose images were
> generated using a particular tool on Acorn RISC OS. The problem is that in
> certain catalogue entries, the extension separator character '/' (RISC OS
> uses '.' and '/' the other way round) was not replaced with '.'; thus Linux
> cannot properly parse this without this patch, thinking that it is a
> directory separator.

-fsdevel is the right list and if you checked I already sent a rfc there
for this and the other iso9660 patch.
