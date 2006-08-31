Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWHaQeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWHaQeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWHaQeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:34:36 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:6885 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932246AbWHaQef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:34:35 -0400
Date: Thu, 31 Aug 2006 17:35:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, pageexec@freemail.hu
Subject: Re: [PATCH][RFC] fix long long cast in pte macro
Message-ID: <20060831163501.GA3433@linux-mips.org>
References: <20060830062718.GA289@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830062718.GA289@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 08:27:18AM +0200, Willy Tarreau wrote:

> PaX Team sent me this patch, which I think is valid. It fixes a long long
> cast in the pte macro for i386 and mips. If nobody has any objections, I
> will apply it to 2.4. I'd also like someone to check whether it's needed
> for 2.6 and to forward port it if needed.

Yes, a similar 2.6 patch is needed as well, I'll care of that.  For the
MIPS segment of your 2.4 patch:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
