Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTESRbC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTESRbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:31:02 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:54020 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262610AbTESRaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:30:52 -0400
Date: Mon, 19 May 2003 18:43:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] unresolved symbols in 2.4.21-rc2-ac2
Message-ID: <20030519184345.A27086@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bernhard Rosenkraenzer <bero@arklinux.org>,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <Pine.LNX.4.53.0305191935020.28211@dot.kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0305191935020.28211@dot.kde.org>; from bero@arklinux.org on Mon, May 19, 2003 at 07:37:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 07:37:05PM +0200, Bernhard Rosenkraenzer wrote:
>  	spin_unlock(&pagecache_lock);
>  	return page;
>  }
> +EXPORT_SYMBOL_GPL(find_trylock_page);

2.5 exports this without _GPL so this is a bit inconsistant..

But yeah, sorry for missing those exports in my update for Alan, I
have XFS builtin usually of course :)
