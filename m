Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266045AbTLIQ31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbTLIQ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:29:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:17088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266045AbTLIQ30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:29:26 -0500
Date: Tue, 9 Dec 2003 08:28:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Domen Puncer <domen@coderock.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.23, 2.6.0-test11] fix d_type in readdir in isofs
In-Reply-To: <200312091047.33015.domen@coderock.org>
Message-ID: <Pine.LNX.4.58.0312090827350.19936@home.osdl.org>
References: <200312091047.33015.domen@coderock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Dec 2003, Domen Puncer wrote:
>
> Played with scandir, and noticed iso9660's files d_type is always 0,
> so here's a fix.

Looks ok, but I can't convince myself to apply this at this point:
there's just not way I can call this a major stability fix ;). Can
somebody keep this around for later?

		Linus
