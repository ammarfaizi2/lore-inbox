Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUEFJwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUEFJwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUEFJwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 05:52:55 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:64643 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261918AbUEFJwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 05:52:54 -0400
Date: Thu, 6 May 2004 11:52:53 +0200
From: Lucas Nussbaum <lucas@lucas-nussbaum.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ne2k-pci uncorrectly detecting collisions ?
Message-ID: <20040506095253.GA9157@blop.info>
References: <20040505123532.GA3011@blop.info> <Pine.LNX.4.53.0405050855290.16355@chaos> <20040505131006.GA3412@blop.info> <200405052245.39405.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405052245.39405.vda@port.imtp.ilyichevsk.odessa.ua>
Organisation: Lacking
X-PGP: http://www.lucas-nussbaum.net/pubkey.txt
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 10:45:39PM +0300, Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> > But what I thought was that maybe, they were initialised as full duplex,
> > not half duplex. But again, I don't know where I can check that. I added
> > some printks and determined that the code used to init them full duplex
> > was never used. And there's no way to force them half duplex with this
> > driver.
> 
> There is a DOS utility which configure duplex settings for RTL8029.
 
Thanks a lot, that did the trick.
-- 
| Lucas Nussbaum
| lucas@lucas-nussbaum.net    lnu@gnu.org    GPG: 1024D/023B3F4F |
| jabber: lucas@linux.ensimag.fr   http://www.lucas-nussbaum.net |
| fingerprint: 075D 010B 80C3 AC68 BD4F B328 DA19 6237 023B 3F4F |
