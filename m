Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVLDTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVLDTzE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVLDTzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 14:55:04 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:64426 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932324AbVLDTzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 14:55:03 -0500
Date: Sun, 4 Dec 2005 11:54:46 -0800
From: Paul Jackson <pj@sgi.com>
To: Marcel Zalmanovici <MARCEL@il.ibm.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, mulix@mulix.org
Subject: Re: Inconsistent timing results of multithreaded program on an SMP
 machine.
Message-Id: <20051204115446.0a026538.pj@sgi.com>
In-Reply-To: <OFF63E8FCE.68FFD508-ONC22570CD.0052EFE9-C22570CD.0054D27C@il.ibm.com>
References: <20051124044313.6259092d.pj@sgi.com>
	<OFF63E8FCE.68FFD508-ONC22570CD.0052EFE9-C22570CD.0054D27C@il.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel wrote:
> I think that the conclusion from this test is that the write-back algorithm
> might be responsible for the oscillating results.

Well ... if you suspect your storage/hardware, then try a different
file system, such as network files or /dev/ramdisk.

It's a few seconds worth of difference you're dealing with, so try
playing around with printf's in the user code and printk's in the
kernel at key points in the sequence of events, so you can see what
happens when.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
