Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTD3Srq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTD3Srp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:47:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2821 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262319AbTD3SrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:47:18 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] use .devfs_name in struct miscdevice
Date: 30 Apr 2003 11:59:32 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8p6ek$tn2$1@cesium.transmeta.com>
References: <20030430173315.A4057@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030430173315.A4057@lst.de>
By author:    Christoph Hellwig <hch@lst.de>
In newsgroup: linux.dev.kernel
>
> There's three drivers in the tree that workaround the suboptimal
> devfs name choice of the misc device layer (/dev/misc/<foo>) using
> devfs_mk_symlink.    Switch them to set miscdev.devfs_name instead
> to get the right name from the very beginning.
> 

Understatement of the week :)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
