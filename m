Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTGFTvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 15:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTGFTvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 15:51:47 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29860
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263319AbTGFTvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 15:51:46 -0400
Subject: Re: 2.4 direct_IO API changing?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F08746C.6010803@pobox.com>
References: <3F08746C.6010803@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057521807.1277.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jul 2003 21:03:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-06 at 20:11, Jeff Garzik wrote:
> I see in 2.4.22-BK-latest:
> 
> > -       int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
> > +       int (*direct_IO)(int, struct file *, struct kiobuf *, unsigned long, int
> 
> 
> Should this really be changing in the middle of a stable series?
> 
> I realize that vendor's are already shipping this difference, but 
> still...  it's a bit of an abrupt midseries change that can potentially 
> break working code.

Its something most people are already shipping and something you
actually do need for some of the direct IO stuff. 

BTW: Marcelo your mail system is broken *again*

