Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWHRQY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWHRQY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWHRQY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:24:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15831 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030220AbWHRQY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:24:58 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Dirk <noisyb@gmx.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0608181428430.2760@be1.lrz>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
	 <6KyCQ-1w7-25@gated-at.bofh.it>  <E1GDgyZ-0000jV-MV@be1.lrz>
	 <1155818138.4494.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0608181428430.2760@be1.lrz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Aug 2006 17:45:47 +0100
Message-Id: <1155919547.30279.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 14:31 +0200, ysgrifennodd Bodo Eggert:
> It's user a destroying the CD of user b (e.g. because he erroneously 
> believes his CD with the plain tar archive is in the burner, or because
> he's simply malicious).

Thats why you need revoke().

Alan

