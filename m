Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbSJIOI4>; Wed, 9 Oct 2002 10:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261776AbSJIOI4>; Wed, 9 Oct 2002 10:08:56 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64016
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261772AbSJIOIy>; Wed, 9 Oct 2002 10:08:54 -0400
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
From: Robert Love <rml@tech9.net>
To: Marco Colombo <marco@esi.it>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.44.0210091606000.26363-100000@Megathlon.ESI>
References: <Pine.LNX.4.44.0210091606000.26363-100000@Megathlon.ESI>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 10:14:26 -0400
Message-Id: <1034172868.746.3707.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 10:10, Marco Colombo wrote:

> >  #define O_NOFOLLOW	0400000 /* don't follow links */
> >  #define O_NOFOLLOW	0x20000	/* don't follow links */
> ...
> 04000000 != 0x400000
> 
> or am I missing something?

No need.  See for example O_NOFOLLOW right above.  Each architecture can
do has it pleases (I wish otherwise, but...).

> (do different archs dream of different O_STREAMING values?)

If they so choose.  Just look at the formats of the two numbers you
posted, even those are different.

	Robert Love


