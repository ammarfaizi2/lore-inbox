Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWGDJJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWGDJJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWGDJJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:09:47 -0400
Received: from webmailv3.ispgateway.de ([80.67.16.113]:50581 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750984AbWGDJJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:09:46 -0400
Message-ID: <1152004172.44aa304cac758@www.domainfactory-webmail.de>
Date: Tue, 04 Jul 2006 11:09:32 +0200
From: Clemens Ladisch <clemens@ladisch.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, James@superbug.demon.co.uk,
       akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] FIx no mpu401 interface can cause hard freeze
References: <44A98261.1000300@oracle.com>
In-Reply-To: <44A98261.1000300@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> This patch fixes the remaining instances in our tree where a non-
> existent mpu401 interface can cause a hard freeze when i/o is
> issued.
>
>  sound/pci/emu10k1/emu10k1x.c
>  sound/pci/emu10k1/emumpu401.c

These drivers are for chips where we know that an MPU-401 interface
exists.

Are there any freezes on these devices that can be resolved by this
patch?


Regards,
Clemens

