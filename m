Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUHOPLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUHOPLI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUHOPJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:09:36 -0400
Received: from imap.infonegocio.com ([213.4.129.150]:25462 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S266762AbUHOPHJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:07:09 -0400
Subject: Re: 2.6.8: IDE cdrecord problems
From: Emilio =?ISO-8859-1?Q?Jes=FAs?= Gallego Arias 
	<egallego@telefonica.net>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20040814231909.30a84b1a@jack.colino.net>
References: <1092512296.5403.11.camel@localhost>
	 <20040814231909.30a84b1a@jack.colino.net>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Aug 2004 17:08:01 +0200
Message-Id: <1092582481.4738.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry I wasn't clear, I'm using too stock 2.6.8.1. I meant will test
with stock 2.6.7.

Also I think it may be related to some of these changelogs:

very likely:
[PATCH] BIO page refcounting fix:

http://linux.bkbits.net:8080/linux-2.5/cset@1.1807.25.6

I'll try to patch -r this and test on Monday.

these changesets are also cdrom or bio related, althought I don't think 
are causing any trouble:

bio_copy_user() cleanups and fixes:
http://linux.bkbits.net:8080/linux-2.5/cset@1.1807.38.2
[PATCH] fix cdrom cdda rip single frame dma fall back
http://linux.bkbits.net:8080/linux-2.5/cset@1.1807.1.68

El sáb, 14-08-2004 a las 23:19 +0200, Colin Leroy escribió:
> On 14 Aug 2004 at 21h08, Emilio Jesús Gallego Arias wrote:
> 
> Hi, 
> 
> > Unfortunately I've no blank media until Monday I can go to the shop :)
> > so will test a stock kernel soon.
> 
> In my case it is a stock kernel. Also, I never saw any of these
> messages before...
> 

