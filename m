Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265457AbTFVCpH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 22:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTFVCpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 22:45:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:14831 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265457AbTFVCpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 22:45:05 -0400
Date: Sat, 21 Jun 2003 19:59:28 -0700
From: Andrew Morton <akpm@digeo.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: acme@conectiva.com.br, torvalds@transmeta.com, geert@linux-m68k.org,
       alan@lxorguk.ukuu.org.uk, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-Id: <20030621195928.13ef95ea.akpm@digeo.com>
In-Reply-To: <20030622022759.GA30107@dingdong.cryptoapps.com>
References: <20030621125111.0bb3dc1c.akpm@digeo.com>
	<Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com>
	<20030622001101.GB10801@conectiva.com.br>
	<20030622014102.GB29661@dingdong.cryptoapps.com>
	<20030622014345.GD10801@conectiva.com.br>
	<20030621191705.3c1dbb16.akpm@digeo.com>
	<20030622022759.GA30107@dingdong.cryptoapps.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 02:59:09.0378 (UTC) FILETIME=[40592A20:01C3386A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Sat, Jun 21, 2003 at 07:17:05PM -0700, Andrew Morton wrote:
> 
> > Compared to 2.95.3, gcc-3.3 takes 1.5x as long to compile, and
> > produces a kernel which is 200k larger.
> 
> Do we know why this is the case?  I assume the fix is far from
> trivial?

Alignment mainly.  It pads stuff all over the place.  A lot of it can be
defeated - but not all, last time I looked.


