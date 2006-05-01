Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWEAS6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWEAS6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWEAS6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:58:07 -0400
Received: from hera.kernel.org ([140.211.167.34]:64670 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750788AbWEAS6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:58:05 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-rc3-mm1
Date: Mon, 1 May 2006 11:57:33 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e35lmt$1iv$1@terminus.zytor.com>
References: <20060501014737.54ee0dd5.akpm@osdl.org> <625fc13d0605010554l4cadac0fxe7fbc6cd5d57c679@mail.gmail.com> <20060501095913.13a74b2b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1146509853 1632 127.0.0.1 (1 May 2006 18:57:33 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 1 May 2006 18:57:33 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060501095913.13a74b2b.akpm@osdl.org>
By author:    Andrew Morton <akpm@osdl.org>
In newsgroup: linux.dev.kernel
> > 
> >  Any specific reasons the header cleanup trees weren't added?
> 
> I'll get onto that later in the month.  I also need to bring in the klibc
> tree.  The two might apparently interact - we'll see..

Hi Andrew,

If it makes your life easier I'd be happy to produce a klibc tree on
top of the header cleanup tree.  klibc really should be built against
the exported headers, which should both make klibc easier to maintain
and provide a degree automatic testing of the exported headers.

	-hpa
