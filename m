Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTFIORG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTFIORG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:17:06 -0400
Received: from [156.26.20.182] ([156.26.20.182]:33478 "EHLO surf.cadcamlab.org")
	by vger.kernel.org with ESMTP id S264368AbTFIORF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:17:05 -0400
Date: Mon, 9 Jun 2003 09:29:56 -0500
To: Christoph Hellwig <hch@infradead.org>, Jaroslav Kysela <perex@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
Subject: Re: 2.5 kbuild: use of '-z muldefs' for LD?
Message-ID: <20030609142956.GH573@cadcamlab.org>
References: <20030609130438.A6417@infradead.org> <Pine.LNX.4.44.0306091550000.1323-100000@pnote.perex-int.cz> <20030609151945.A10352@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609151945.A10352@infradead.org>
User-Agent: Mutt/1.5.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Christoph Hellwig]
> Well, if you want separate copies of it you have to make sure the
> symbols won't clash, e.g. calling all functions in it
> 
> MYPREFIX_foo
> 
> and then do #define MYPREFIX	KBUILD_MODNAME

...or just move everything into a header file as static functions.
Inline, even, if the code is really trivial enough that you don't want
to make a separate module of it.

Peter
