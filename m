Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272576AbTHKNbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272577AbTHKNbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:31:43 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:55308 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S272576AbTHKNbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:31:39 -0400
Date: Mon, 11 Aug 2003 23:31:18 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
cc: Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>,
       <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
       <kernel@gozer.org>, <axboe@suse.de>
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
In-Reply-To: <20030811083634.B5817340013E@mwinf0601.wanadoo.fr>
Message-ID: <Mutt.LNX.4.44.0308112328500.10934-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Pascal Brisset wrote:

>  > Ok, please take into account the case where src == dst.
> 
> OK, looks like there is a tricky interplay between algorithms and
> transforms.  Cipher implementors will need documentation here, e.g.
> "cia_encrypt and cia_decrypt are always called with src==dst UNLESS
> we are running in CBC mode AND cia_ivsize!=0" (Please confirm...)

All implementors need to know at that level is that src may equal dst.


- James
-- 
James Morris
<jmorris@intercode.com.au>

