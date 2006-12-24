Return-Path: <linux-kernel-owner+w=401wt.eu-S1751007AbWLXMWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWLXMWt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 07:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWLXMWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 07:22:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60130 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbWLXMWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 07:22:49 -0500
Date: Sun, 24 Dec 2006 04:22:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       marcel@holtmann.org, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: ptrace() memory corruption?
Message-Id: <20061224042225.51a6619a.akpm@osdl.org>
In-Reply-To: <458E69CB.6000107@gmail.com>
References: <20061223234305.GA1809@elf.ucw.cz>
	<20061223235501.GA1740@elf.ucw.cz>
	<20061224000150.GA1812@elf.ucw.cz>
	<20061224000605.GA1768@elf.ucw.cz>
	<20061224000753.GA1811@elf.ucw.cz>
	<458DD459.2030209@gmail.com>
	<458E69CB.6000107@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Dec 2006 12:51:16 +0059
Jiri Slaby <jirislaby@gmail.com> wrote:

> [   58.674780] EFLAGS: 00010046   (2.6.20-rc1-mm1 #207)

please, test 2.6.20-rc2.  We applied a fix for this.
