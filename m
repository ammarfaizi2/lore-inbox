Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbUKECn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbUKECn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbUKECn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:43:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24233 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262573AbUKECnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:43:25 -0500
Message-ID: <418AE8C0.3040205@pobox.com>
Date: Thu, 04 Nov 2004 21:43:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] IDE remove some cruft from ide.h
References: <20041103091101.GC22469@taniwha.stupidest.org>
In-Reply-To: <20041103091101.GC22469@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart, Chris's two patches are OK with me.  If you agree, then please 
merge them up into your ide-2.6 queue.

Chris, a useful follow-up patch (if Bart agrees) is a global 
search-n-replace of WIN_xxx constants with ATA_CMD_xxx constants. 
Depending on the size of the patch, it might even need to be split up 
across several patches.

	Jeff



