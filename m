Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUEaKS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUEaKS1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 06:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUEaKS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 06:18:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:29091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263040AbUEaKS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 06:18:26 -0400
Date: Mon, 31 May 2004 03:17:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: ncunningham@linuxmail.org, cef-lkml@optusnet.com.au,
       linux-kernel@vger.kernel.org, rob@landley.net, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-Id: <20040531031743.0d7566e3.akpm@osdl.org>
In-Reply-To: <20040529222308.GA1535@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net>
	<20040528215642.GA927@elf.ucw.cz>
	<200405291905.20925.cef-lkml@optusnet.com.au>
	<40B85024.2040505@linuxmail.org>
	<20040529222308.GA1535@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw, software suspend wrecks your swap partition if you suspend to swap but
do not resume from swap - you need to run mkswap again.  Seems odd.

