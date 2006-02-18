Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWBRQze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWBRQze (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWBRQze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:55:34 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:43999 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932077AbWBRQzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:55:33 -0500
Date: Sat, 18 Feb 2006 17:55:49 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: omkar lagu <omkarlagu@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel hook...
Message-ID: <20060218165549.GA5791@stiffy.osknowledge.org>
References: <20060218145152.85941.qmail@web50309.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218145152.85941.qmail@web50309.mail.yahoo.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc4-marc-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* omkar lagu <omkarlagu@yahoo.com> [2006-02-18 06:51:52 -0800]:

> hi all,
> 
> help needed.. 
> we want to call a function from the kernel code which
> is defined in our module and the function should be
> only called when we insert our module in the kernel.
> we are really struggling with this..can anyone suggest
> a solution for this with a example.
> 
> thanks in advance 

static int __init init_my_module (void) {
	call_function();

	return 0;
}
EXPORT_SYMBOL(init_my_module);

Marc
