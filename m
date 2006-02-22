Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWBVNrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWBVNrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWBVNrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:47:23 -0500
Received: from relay4.usu.ru ([194.226.235.39]:30099 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751285AbWBVNrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:47:21 -0500
Message-ID: <43FC6B8F.4060601@ums.usu.ru>
Date: Wed, 22 Feb 2006 18:47:59 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc4-mm1
References: <20060220042615.5af1bddc.akpm@osdl.org>
In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.17; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
plus hotfixes

Unfortunately, I lost my .config from the old kernel, so I attempted the 
following:

cd scripts
make binoffset
cd ..
scripts/extract-ikconfig /boot/vmlinuz-2.6.16-rc3-mm1-home >.config

This results in:

zcat: stdin: decompression OK, trailing garbage ignored

Note: I have not compiled this kernel yet, so there will be probably 
another report of real issues.

-- 
Alexander E. Patrakov
