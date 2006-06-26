Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWFZDOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWFZDOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 23:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWFZDOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 23:14:39 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57243 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751120AbWFZDOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 23:14:39 -0400
Message-ID: <449F511C.6020303@garzik.org>
Date: Sun, 25 Jun 2006 23:14:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 12/43] Enable CONFIG_KLIBC_ZLIB (now required to build
 kinit)
References: <klibc.200606251757.12@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606251757.12@tazenda.hos.anvin.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> After removing the private copy of zlib in kinit, we need
> CONFIG_KLIBC_ZLIB in order to build klibc.  zlib is required in order
> to decompress classical ramdisks.
> 
> In the future this should maybe be made conditional on CONFIG_BLK_DEV_RAM.

> +config KLIBC_ZLIB
> +	bool
> +	default y


Dumb question, then:  why not make it conditional on rd now?

	Jeff


