Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbTGHQ3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTGHQ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:29:49 -0400
Received: from www.13thfloor.at ([212.16.59.250]:50566 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S264660AbTGHQ3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:29:44 -0400
Date: Tue, 8 Jul 2003 18:44:26 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: trond.myklebust@fys.uio.no, Marcelo Tosatti <marcelo@conectiva.com.br>,
       hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count (Changelog@1.1024.1.11)
Message-ID: <20030708164426.GB10004@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	trond.myklebust@fys.uio.no,
	Marcelo Tosatti <marcelo@conectiva.com.br>, hannal@us.ibm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux FSdevel <linux-fsdevel@vger.kernel.org>
References: <16138.53118.777914.828030@charged.uio.no> <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk> <16138.56467.342593.715679@charged.uio.no> <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 04:20:14PM +0100, Alan Cox wrote:
> On Maw, 2003-07-08 at 16:00, Trond Myklebust wrote:
> > ...but I do agree with your comment. The patch I meant to refer to
> > (see revised title) does not appear in the 2.5.x tree either.
> > 
> > Have we BTW been shown any numbers that support the alleged benefits?
> > I may have missed those...
> 
> A while ago yes - on very big SMP boxes.
> 
> Its no big problem to me since I can just back it out of -ac

just curious, because I use this patch since early 2.4.20,
are there any reasons to 'back it out of -ac' for you?

anyway I totally agree that the NFS issue pointed out by 
Trond should be addressed ...

TIA,
Herbert

