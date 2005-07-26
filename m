Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVGZVlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVGZVlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVGZVjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:39:23 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:45207 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S262064AbVGZVhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:37:35 -0400
Date: Tue, 26 Jul 2005 17:23:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Message-ID: <200507261727_MC3-1-A5A1-F8AA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2005 at 10:38:40 -0700 (PDT), Linus Torvalds wrote:

> On Sat, 23 Jul 2005, Chuck Ebbert wrote:
> > 
> > This patch (may not apply cleanly to unpatched -rc3) drops overhead
> > a few more percent:
>
> That really is pretty ugly.
>
> I'd rather hope for something like function-sections to just make games 
> like this be unnecessary.

 The link stage might cause meltdown on typical machines, though.
__
Chuck
