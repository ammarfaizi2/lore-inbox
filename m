Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUCVMza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUCVMz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:55:29 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:1476 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S261940AbUCVMz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:55:27 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stepan Yakovenko <yakovenko@ngs.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: =?KOI8-R?Q?=E1_trouble_with_2=2E4=2E25_linux_kernel?= 
In-reply-to: Your message of "Mon, 22 Mar 2004 18:38:21 +0600."
             <405EDE3D.6050805@ngs.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Mar 2004 23:54:57 +1100
Message-ID: <2784.1079960097@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004 18:38:21 +0600, 
Stepan Yakovenko <yakovenko@ngs.ru> wrote:
>In file included from 
>/root/linux-2.4.25/include/linux/modversions.h:69,       
>/root/linux-2.4.25/include/linux/module.h:21,            
>ksyms.c:14:                                              
>/root/linux-2.4.25/include/linux/modules/dec_and_lock.ver:2: warning: 
>`atomic_dec_and_lock' redefined                                                          

You must 'make dep' after changing processor type in 2.4 kernels.  To
be absolutely safe, move your .config to another directory, make
mrproper, move .config back then make oldconfig dep.

