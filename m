Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273781AbSISXQQ>; Thu, 19 Sep 2002 19:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273784AbSISXQQ>; Thu, 19 Sep 2002 19:16:16 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:26361
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S273781AbSISXQP>; Thu, 19 Sep 2002 19:16:15 -0400
Subject: Re: ext3 fs: no userspace writes == no disk writes ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <3D8A57F8.AFC627AD@digeo.com>
References: <20020920003058.A4850@verdi.et.tudelft.nl> 
	<3D8A57F8.AFC627AD@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Sep 2002 00:25:59 +0100
Message-Id: <1032477959.29068.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-20 at 00:04, Andrew Morton wrote:
> There are frequently written areas of an ext3 filesystem - the
> journal, the superblock.  Those would wear out pretty quickly.

CF is -supposed- to wear level.

> Increasing the commit interval to the maximum acceptable time
> would reduce some of this wear and tear.

Other one is the usual laptop noatime setting

