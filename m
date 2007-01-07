Return-Path: <linux-kernel-owner+w=401wt.eu-S932433AbXAGI0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbXAGI0e (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 03:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbXAGI0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 03:26:34 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:40188 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433AbXAGI0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 03:26:33 -0500
Message-ID: <45A0AE5C.6010801@gmail.com>
Date: Sun, 07 Jan 2007 09:25:00 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Amit Choudhary <amit2030@yahoo.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DISCUSS] Making system calls more portable.
References: <722886.55398.qm@web55601.mail.re4.yahoo.com>
In-Reply-To: <722886.55398.qm@web55601.mail.re4.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2007 09:15 AM, Amit Choudhary wrote:

> Well, system calls today are not portable mainly because they are
> invoked using a number and it may happen that a number 'N' may refer
> to systemcall_1() on one system/kernel and to systemcall_2() on
> another system/kernel.

If we're limited to Linux kernels, this seems to not be the case. Great 
care is taken in keeping this userspace ABI stable -- new system calls 
are given new numbers. Old system calls may disappear (after a long 
grace period) but even then I don't believe the number is ever recycled.

If your discussion is not limited to Linux kernels, then sure, but being 
portable at that (sub-libc) level is asking too much.

> I hope that I made some sense.

Some, but your supposition seems unclear.

Rene
