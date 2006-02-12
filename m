Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWBLP3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWBLP3f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 10:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWBLP3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 10:29:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61584 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751136AbWBLP3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 10:29:34 -0500
Subject: Re: + isdn4linux-siemens-gigaset-drivers-common-module.patch added
	to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: hjlipp@web.de, greg@kroah.com, kkeil@suse.de, tilman@imap.cc,
       akpm@osdl.org
In-Reply-To: <200602121032.k1CAWLTg002183@shell0.pdx.osdl.net>
References: <200602121032.k1CAWLTg002183@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sun, 12 Feb 2006 16:29:29 +0100
Message-Id: <1139758170.20703.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 02:31 -0800, akpm@osdl.org wrote:
> The patch titled
> 
>      isdn4linux: Siemens Gigaset drivers - common module
> 
> has been added to the -mm tree.  Its filename is
> 
>      isdn4linux-siemens-gigaset-drivers-common-module.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> 
> From: Hansjoerg Lipp <hjlipp@web.de>
> 
> And: Tilman Schmidt <tilman@imap.cc>



> +struct prot_skb {
> +	atomic_t		empty;
> +	struct semaphore	*sem;
> +	struct sk_buff		*skb;
> +};
> +


please consider using mutexes instead!


