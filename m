Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUH2PW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUH2PW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUH2PW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:22:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:6017 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268031AbUH2PWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:22:55 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093789225.27932.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 15:20:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-25 at 21:22, Linus Torvalds wrote:
>  - without the slash, a file-as-dir won't open with O_DIRECTORY (ENOTDIR)
>  - with the slash, it won't open _without_ O_DIRECTORY (EISDIR)
> 
> Problem solved. Very user-friendly, and very intuitive.

Breaks bash and almost all other file completion 8)

