Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUJ3QSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUJ3QSe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUJ3QR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:17:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11422 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261187AbUJ3QNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 12:13:52 -0400
Message-ID: <4183BDB3.8000302@pobox.com>
Date: Sat, 30 Oct 2004 12:13:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>
CC: linux-kernel@vger.kernel.org, Daniele Venzano <webvenza@libero.it>
Subject: Re: [PATCH] WOL for sis900
References: <4183B6B0.7010906@gmx.de>
In-Reply-To: <4183B6B0.7010906@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Malte Schröder wrote:
> Hello,
> I have applied the patch from http://lkml.org/lkml/2003/7/16/88 manually 
> to 2.6.7 (also works on 2.6.{8,9}) and have been using it since then.
> Attached is a diff against 2.6.9.

Two comments:

1) Please include a signed-off-by line, as per

	http://linux.yyz.us/patch-format.html
		and
	http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

2) Please use ethtool to enable/disable WOL.  No need for a module option.

