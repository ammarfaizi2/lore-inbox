Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWAWTEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWAWTEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWAWTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:04:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57018 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964900AbWAWTEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:04:44 -0500
Subject: Re: Rationale for RLIMIT_MEMLOCK?
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060123185549.GA15985@merlin.emma.line.org>
References: <20060123105634.GA17439@merlin.emma.line.org>
	 <1138014312.2977.37.camel@laptopd505.fenrus.org>
	 <20060123165415.GA32178@merlin.emma.line.org>
	 <1138035602.2977.54.camel@laptopd505.fenrus.org>
	 <20060123180106.GA4879@merlin.emma.line.org>
	 <1138039993.2977.62.camel@laptopd505.fenrus.org>
	 <20060123185549.GA15985@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 20:04:36 +0100
Message-Id: <1138043076.2977.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 19:55 +0100, Matthias Andree wrote:
> On Mon, 23 Jan 2006, Arjan van de Ven wrote:
> 
> > hmm... curious that mlockall() succeeds with only a 32kb rlimit....
> 
> It's quite obvious with the seteuid() shuffling behind the scenes of the
> app, for the mlockall() runs with euid==0, and the later mmap() with euid!=0.

hmm how on earth was that supposed to work at all????



