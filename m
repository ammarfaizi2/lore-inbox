Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTDVCNq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbTDVCNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:13:46 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:41090 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262834AbTDVCNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:13:45 -0400
Subject: Re: 2.5.67 and QM_MODULES
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Bob Gill <gillb4@telusplanet.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1050964512.1539.19.camel@localhost.localdomain>
References: <1050964512.1539.19.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1050978339.607.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 22 Apr 2003 04:25:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 00:35, Bob Gill wrote:
> I can build kernel 2.5.67 just fine.  I boot the kernel, and get
> 'QM_MODULES is unsupported'.  I have already upgraded modutils to
> version modutils-2.4.25 and module-init-tools-0.9.11a --and still get
> the error message in dmesg 'QM_MODULES is unsupported'.

Are you sure you aren't mixing older modutils with newer ones in $PATH?
If you can install RPM packages, download and compile the SRPM from
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules. If not, make
sure your PATH is set correctly.
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

