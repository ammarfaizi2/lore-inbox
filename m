Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVFUISC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVFUISC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVFUIQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:16:54 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:46216 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261586AbVFUH3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:29:10 -0400
Date: Tue, 21 Jun 2005 09:29:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Luc Saillard <luc@saillard.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][1/3] pwc-uncompress cleanup - whitespace cleanups.
Message-ID: <20050621072905.GD27887@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.62.0506202303050.2369@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0506202303050.2369@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 June 2005 23:11:19 +0200, Jesper Juhl wrote:
> 
> There are no functional changes made by the patch.
>
> [...]
>
> -					dstv += (stride >> 1);
> +					*dstv++ = *src++;
>  				else
> -					dstu += (stride >> 1);
> +					*dstu++ = *src++;

Your claim above may be true, but that's somewhat hard to verify.  At
the very least, this is *not* a pure whitespace cleanup.

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams
