Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264149AbUDGIFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 04:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbUDGIFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 04:05:33 -0400
Received: from ozlabs.org ([203.10.76.45]:26829 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264149AbUDGIF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 04:05:27 -0400
Date: Wed, 7 Apr 2004 18:03:20 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, paulus@samba.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-ID: <20040407080320.GN26474@krispykreme>
References: <20040407074239.GG18264@zax> <20040407005353.45323dcd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407005353.45323dcd.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Not much, except that it adds stuff to the kernel.
> 
> Does anyone actually have a real-world need for the feature?

Ive been playing with a malloc library that uses largepages. It needs
largepage COW to work.

Anton
