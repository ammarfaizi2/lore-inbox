Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966482AbWKNXin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966482AbWKNXin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966484AbWKNXin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:38:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966482AbWKNXim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:38:42 -0500
Date: Tue, 14 Nov 2006 15:35:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Ingo Molnar <mingo@redhat.com>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use delayed disable mode of ioapic edge triggered
 interrupts
In-Reply-To: <m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0611141534070.4144@woody.osdl.org>
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
 <1162985578.8335.12.camel@localhost.localdomain> <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
 <20061108085235.GT4729@stusta.de> <7813413.118221162987983254.komurojun-mbn@nifty.com>
 <11940937.327381163162570124.komurojun-mbn@nifty.com>
 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org> <m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
 <1163450677.7473.86.camel@earth> <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
 <1163492040.28401.76.camel@earth> <Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
 <m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, Eric W. Biederman wrote:
> 
> Hopefully this is the trivial patch that solves the problem.

Komuro, can you check this patch _instead_ of the one from Ingo (ie not 
together with, since that combination won't tell us anything new - if 
Ingo's patch is there too, the new patch will basically be a no-op).

		Linus
