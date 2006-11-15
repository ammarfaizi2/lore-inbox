Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161693AbWKOVOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161693AbWKOVOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161705AbWKOVOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:14:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33457 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161693AbWKOVOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:14:41 -0500
Subject: Re: [patch] floppy: suspend/resume fix
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20061115204933.GD3875@elf.ucw.cz>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se>
	 <20061112212941.GA31624@flint.arm.linux.org.uk>
	 <20061112220318.GA3387@elte.hu>
	 <20061112235410.GB31624@flint.arm.linux.org.uk>
	 <20061114110958.GB2242@elf.ucw.cz> <1163522062.14674.3.camel@mindpipe>
	 <20061115202418.GC3875@elf.ucw.cz>
	 <20061115204915.1d0717db@localhost.localdomain>
	 <20061115204933.GD3875@elf.ucw.cz>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 22:14:37 +0100
Message-Id: <1163625278.31358.161.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yep, it would be nice to do something about that; but I'm not sure how
> this "was media changed" should be implemented, and if it should be
> done in kernel or in userland.

well I guess step 1 is to sync_bdev() or whatever it is called nowadays
before suspend. And maybe force unmount on resume always? 


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

