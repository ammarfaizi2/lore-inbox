Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263680AbVCEEfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbVCEEfW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbVCDXmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:42:05 -0500
Received: from smartmx-02.inode.at ([213.229.60.34]:7904 "EHLO
	smartmx-02.inode.at") by vger.kernel.org with ESMTP id S263208AbVCDVwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:52:42 -0500
Message-ID: <4228D8A6.3080402@inode.info>
Date: Fri, 04 Mar 2005 22:52:38 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption in skb allocs
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <20050304201153.GR3163@waste.org> <4228D0D9.9010301@inode.info> <20050304212730.GZ3120@waste.org>
In-Reply-To: <20050304212730.GZ3120@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

> Doh. 'ethtool -k' is what's needed, sorry.

doh myself. :) this won't be very helpful though, as i get the same on 
all machines (with both drivers):

Offload parameters for eth0:
Cannot get device rx csum settings: Operation not supported
Cannot get device tx csum settings: Operation not supported
Cannot get device scatter-gather settings: Operation not supported
Cannot get device tcp segmentation offload settings: Operation not supported
no offload info available

> ethtool -k eth0 rx off tx off

ditto. i'll try to reproduce this on a machine with e1000 though...


cheers
richard
