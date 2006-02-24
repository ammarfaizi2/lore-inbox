Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWBXLKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWBXLKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWBXLKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:10:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750895AbWBXLKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:10:17 -0500
Date: Fri, 24 Feb 2006 03:09:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mark Rustad <mrustad@mac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc4 edac oops
Message-Id: <20060224030935.22c19f99.akpm@osdl.org>
In-Reply-To: <6B9658D7-1522-4936-9492-FED2DFD38D2A@mac.com>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	<6B9658D7-1522-4936-9492-FED2DFD38D2A@mac.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rustad <mrustad@mac.com> wrote:
>
> I find that I sometimes get a non-fatal oops during boot with the  
>  7520 EDAC stuff in place. 

Could you send a trace which hasn't been passed through ksymoops please?

Make sure that CONFIG_KALLSYMS is set - the kernel internally does all that
decoding now.

