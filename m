Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUCIJzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 04:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUCIJzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 04:55:25 -0500
Received: from host24.tni.fr ([195.25.255.24]:10249 "HELO ender.tni.fr")
	by vger.kernel.org with SMTP id S261850AbUCIJzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 04:55:23 -0500
Subject: Re: [PATCH] UTF-8ifying the kernel source
From: Xavier Bestel <xavier.bestel@free.fr>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c2j36d$2ej$1@terminus.zytor.com>
References: <20040304100503.GA13970@havoc.gtf.org>
	 <20040305232425.GA6239@havoc.gtf.org> <c2b2o0$cbp$1@terminus.zytor.com>
	 <1078571331.963.3.camel@bip.parateam.prv> <c2j36d$2ej$1@terminus.zytor.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1078825743.1558.21.camel@speedy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 09 Mar 2004 10:49:03 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-09 at 00:30 +0000, H. Peter Anvin wrote:

> Followup to:  <1078571331.963.3.camel@bip.parateam.prv>
> By author:    Xavier Bestel <xavier.bestel@free.fr>
> > ISO-8859-1 characters are mostly the same in UTF-8.
> > 
> 
> Unicode, yes.  UTF-8, no.  The ISO-8859-1 character "Å" (0xC5) does,
> indeed correspond to Unicode character U+00C5, but it's encoded 0xC3
> 0x85 in UTF-8.

Yeah, that's what I realized, after posting of course.
While utf-8ying the sources is certainly a good thing, I have mixed
feelings about kernel strings. It will render poorly in some
environments.
Maybe the all-ascii route is better for strings ?

	Xav

