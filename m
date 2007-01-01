Return-Path: <linux-kernel-owner+w=401wt.eu-S932876AbXAAB7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbXAAB7s (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 20:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932861AbXAAB7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 20:59:47 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:4220 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932876AbXAAB7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 20:59:46 -0500
Date: Mon, 1 Jan 2007 02:59:32 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Arjan van de Ven <arjan@infradead.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Message-ID: <20070101015932.GP13521@vanheusden.com>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
	<200612302149.35752.vda.linux@googlemail.com>
	<Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
	<1167518748.20929.578.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0612301750550.16519@localhost.localdomain>
	<20061231183949.GA8323@linux-sh.org>
	<Pine.LNX.4.64.0612311355520.17978@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612311355520.17978@localhost.localdomain>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Jan  1 01:26:42 CET 2007
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > regarding alignment that don't allow clear_page() to be used
> > copy_page() in the memcpy() case), but it's going to need a lot of

Maybe these optimalisations should be in the coding style docs?


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
