Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVAGXVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVAGXVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVAGXUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:20:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:23770 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261703AbVAGXPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:15:44 -0500
Date: Fri, 7 Jan 2005 15:20:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: chrisw@osdl.org, rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       arjanv@redhat.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, joq@io.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050107152004.0f8c488e.akpm@osdl.org>
In-Reply-To: <200501072301.j07N1TW2027950@turing-police.cc.vt.edu>
References: <200501071620.j07GKrIa018718@localhost.localdomain>
	<1105132348.20278.88.camel@krustophenia.net>
	<20050107134941.11cecbfc.akpm@osdl.org>
	<200501072207.j07M7Lda004987@turing-police.cc.vt.edu>
	<20050107143638.L2357@build.pdx.osdl.net>
	<200501072301.j07N1TW2027950@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> fix the inheritance problems

Does anyone actually have a handle on what's involved in fixing the
inheritance problem?

It's risky, but it is something which we should do.

<grumpytroll> We really shouldn't have merged all that new fancy security
stuff when the existing security framework was known-badly-broken. 
Especially as the new stuff seems incapable of doing simple things which
unbroken inherited caps would do perfectly.</grumpytroll>
