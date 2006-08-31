Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWHaQ6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWHaQ6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWHaQ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:58:41 -0400
Received: from 1wt.eu ([62.212.114.60]:50449 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932380AbWHaQ6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:58:40 -0400
Date: Thu, 31 Aug 2006 18:58:01 +0200
From: Willy Tarreau <w@1wt.eu>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, pageexec@freemail.hu
Subject: Re: [PATCH][RFC] fix long long cast in pte macro
Message-ID: <20060831165801.GA341@1wt.eu>
References: <20060830062718.GA289@1wt.eu> <20060831163501.GA3433@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060831163501.GA3433@linux-mips.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 05:35:01PM +0100, Ralf Baechle wrote:
> On Wed, Aug 30, 2006 at 08:27:18AM +0200, Willy Tarreau wrote:
> 
> > PaX Team sent me this patch, which I think is valid. It fixes a long long
> > cast in the pte macro for i386 and mips. If nobody has any objections, I
> > will apply it to 2.4. I'd also like someone to check whether it's needed
> > for 2.6 and to forward port it if needed.
> 
> Yes, a similar 2.6 patch is needed as well, I'll care of that.  For the
> MIPS segment of your 2.4 patch:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
>   Ralf

Thanks Ralf,
Willy

