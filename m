Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUDGVrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUDGVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:47:15 -0400
Received: from ozlabs.org ([203.10.76.45]:19423 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264198AbUDGVpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:45:35 -0400
Date: Thu, 8 Apr 2004 07:41:16 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: david@gibson.dropbear.id.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, paulus@samba.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-ID: <20040407214116.GA18493@krispykreme>
References: <20040407074239.GG18264@zax> <20040407143447.4d8f08af.ak@suse.de> <20040407142748.GO26474@krispykreme> <20040407165041.23d8d82a.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407165041.23d8d82a.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> All they did was to modify the code to lazy faulting. That is
> architecture specific
> 
> (and add the mpol code, but that was pretty minor) 
> 
> COW is a different thing though.

Why is it architecture specific? I dont understand why you cant make
lazy faulting common code.
 
Anton
