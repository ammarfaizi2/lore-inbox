Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUAVMhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 07:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUAVMhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 07:37:54 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:15623 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266245AbUAVMhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 07:37:53 -0500
Subject: Re: 2.6.2-rc1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: sclark46@earthlink.net
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <400F527B.3070505@earthlink.net>
References: <400F527B.3070505@earthlink.net>
Content-Type: text/plain
Message-Id: <1074775066.1582.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 22 Jan 2004 13:37:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-22 at 05:32, Stephen Clark wrote:
> Hello,
> 
> I am running RH9 with the latest kernel and get the following when I try 
> to use rpm:
> rpm -qa
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages index using db3 - Resource temporarily 
> unavailable (11)
> error: cannot open Packages database in /var/lib/rpm
> no packages

rm -fr /var/lib/rpm/__db*

That should fix your problems.

