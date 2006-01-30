Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWA3O67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWA3O67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 09:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWA3O67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 09:58:59 -0500
Received: from ns1.suse.de ([195.135.220.2]:9928 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932264AbWA3O66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 09:58:58 -0500
Date: Mon, 30 Jan 2006 15:58:59 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, olh@suse.de, balbir@in.ibm.com
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060130145859.GG9181@hasse.suse.de>
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060130120318.GB9181@hasse.suse.de> <43DE25F0.6070709@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DE25F0.6070709@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, Kirill Korotaev wrote:

> Hello Jan,
> 
> this is much cleaner now and looks more like my original patch and is 
> smaller/more beautifull with counters usage. Thanks.

Yes, it is heavily inspired by you patch.

> However, with counters instead of list it is possible to create a live 
> lock :( So I'm not sure it is really ok.

Hmm, I don't really get what you mean with "live lock".

> BTW, what kernel is it for? 2.6.15 or 2.6.16-X?

http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git from
today.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
