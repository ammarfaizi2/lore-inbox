Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWH1G3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWH1G3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 02:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWH1G3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 02:29:47 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:34983 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932382AbWH1G3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 02:29:47 -0400
Message-ID: <44F28D58.8060307@garzik.org>
Date: Mon, 28 Aug 2006 02:29:44 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <20060827231421.f0fc9db1.akpm@osdl.org>
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> From: Keith Owens <kaos@ocs.com.au>
> Subject: 2.6.18-rc4 Intermittent failures to detect sata disks

Should already be fixed in -rc5, by

commit f3745a3f9fa39fa3c62f7d5b8549ee787d2c6848
Author: Tejun Heo <htejun@gmail.com>
Date:   Tue Aug 22 21:06:46 2006 +0900

     [PATCH] ata_piix: ignore PCS on ICH5

BTW, as of 9dd9c16465c82d1385f97d2a245641464fcb7894 we have a force_pcs 
module (& command line) parameter which can tune the driver a bit, if 
people are having problems.

	JEff


