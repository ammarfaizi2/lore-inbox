Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266029AbUAQKI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 05:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266030AbUAQKI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 05:08:28 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:28378 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266029AbUAQKIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 05:08:23 -0500
Date: Sat, 17 Jan 2004 02:08:15 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: colpatch@us.ibm.com, akpm@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap parsing routines, version 3
Message-Id: <20040117020815.3ac17c46.pj@sgi.com>
In-Reply-To: <20040117063618.GA14829@tsunami.ccur.com>
References: <16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115161732.458159f5.pj@sgi.com>
	<400873EC.2000406@us.ibm.com>
	<20040117063618.GA14829@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	bitmap_clear(maskp, nmaskbits);

Might be better to clear all the bits in the mask,
not just the low order nmaskbits worth.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
