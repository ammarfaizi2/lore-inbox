Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUAOCMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUAOCMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:12:52 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:42631 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S264608AbUAOCMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:12:50 -0500
Subject: Re: dmesg gives me request_module fail 2.6.1
From: Stian Jordet <liste@jordet.nu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Eric Blade <eblade@blackmagik.dynup.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20040115101044.292e36f8.rusty@rustcorp.com.au>
References: <20040113112123.21902bbf.eblade@blackmagik.dynup.net>
	 <20040115101044.292e36f8.rusty@rustcorp.com.au>
Content-Type: text/plain
Message-Id: <1074132756.3218.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 03:12:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 15.01.2004 kl. 00.10 skrev Rusty Russell:
> On Tue, 13 Jan 2004 11:21:23 -0500
> Eric Blade <eblade@blackmagik.dynup.net> wrote:
> 
> > request_module: failed /sbin/modprobe -- net-pf-10. error = 65280
> 
> A more recent module-init-tools will not return failure when asked to
> modprobe something it's never heard of (with -q, which the kernel uses,
> despite that misleading message)  eg:
> 
> 	modprobe -q -- aalsfdhjlsfdjkhsfhkh
> 
> Will "succeed".

Nah.. sorry :)

chevrolet:~# dmesg|grep request_module|wc -l
108
chevrolet:~# modprobe -V
module-init-tools version 3.0-pre5
chevrolet:~#

Best regards,
Stian

