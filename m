Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTLWPMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTLWPLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:11:53 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:64917 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261262AbTLWPLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:11:44 -0500
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
From: Christophe Saout <christophe@saout.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3d6aga3kr.fsf@averell.firstfloor.org>
References: <15G6g-4oz-17@gated-at.bofh.it> <15Gg9-4H6-25@gated-at.bofh.it>
	 <m3d6aga3kr.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1072192299.5440.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 16:11:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 22.12.2003 schrieb Andi Kleen um 23:29:

> > this is the actual dm-crypt target. It uses cryptoapi to achive the same
> > goal as cryptoloop.
>
> Is the IV argument compatible to block backed loop? 

Yes. You can mount filesystems created on cryptoloop devices with
dm-crypt.

There are plans to go beyond what cryptoloop can do (without giving up
compatibility) though, like being able to use a hash of the sector
number as iv using a digest algorithm for better security.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

