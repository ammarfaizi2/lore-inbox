Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272482AbTGZNOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 09:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272483AbTGZNOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 09:14:36 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:33289 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272482AbTGZNOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 09:14:35 -0400
Subject: Re: Loading of modules fails while using  kernel 2.6.0-test1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Manjunathan Padua Yellappan <manjunathan_py@yahoo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726131956.92831.qmail@web14203.mail.yahoo.com>
References: <20030726131956.92831.qmail@web14203.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1059226184.637.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sat, 26 Jul 2003 15:29:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 15:19, Manjunathan Padua Yellappan wrote:
>  Now I am encountering another problem, after
> successful compilation/installation/booting of kernel
> 2.6.0-test1 , the modules are not loading at all ,
> even after installing the latest version of
> "module-init-tools-0.9.13-pre" .

What's the output of running the following command as root:

cat /proc/sys/kernel/modprobe

