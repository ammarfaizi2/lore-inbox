Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTGHPJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTGHPJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:09:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26028
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263752AbTGHPIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:08:46 -0400
Subject: RE: [PATCH] Fastwalk: reduce cacheline bouncing of d_count
	(Changelog@1.1024.1.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trond.myklebust@fys.uio.no
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <16138.56467.342593.715679@charged.uio.no>
References: <16138.53118.777914.828030@charged.uio.no>
	 <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk>
	 <16138.56467.342593.715679@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 16:20:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 16:00, Trond Myklebust wrote:
> ...but I do agree with your comment. The patch I meant to refer to
> (see revised title) does not appear in the 2.5.x tree either.
> 
> Have we BTW been shown any numbers that support the alleged benefits?
> I may have missed those...

A while ago yes - on very big SMP boxes.

Its no big problem to me since I can just back it out of -ac

