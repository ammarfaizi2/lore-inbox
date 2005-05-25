Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVEYGSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVEYGSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 02:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVEYGSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 02:18:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49577 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261333AbVEYGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 02:18:42 -0400
Subject: Re: BUG() in radix-tree.c, 2.6.11, reiserfs ?
From: Arjan van de Ven <arjan@infradead.org>
To: Stephane Jourdois <kwisatz@rubis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
In-Reply-To: <20050524224802.GA11957@diamant.rubis.org>
References: <20050524224802.GA11957@diamant.rubis.org>
Content-Type: text/plain
Date: Wed, 25 May 2005 08:18:06 +0200
Message-Id: <1117001887.6010.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 00:48 +0200, Stephane Jourdois wrote:
> Hello all,
> 
> I was burning a DVD-R at 16x speed on IDE, the .iso was on /dev/sda1,
> which is a reiserfs part on a SATA disk.  I was at the same time
> building another .iso on /dev/sda1, with files from an lvm spawned on
> /dev/sd{b,c,d}.

I suggest you try it again but without the "evil" nvidia driver.


