Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVCHUk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVCHUk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVCHUko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:40:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:58260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262136AbVCHUg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:36:27 -0500
Date: Tue, 8 Mar 2005 12:35:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistent kallsyms data [2.6.11-mm2]
Message-Id: <20050308123554.669dd725.akpm@osdl.org>
In-Reply-To: <20050308192900.GA16882@isilmar.linta.de>
References: <20050308033846.0c4f8245.akpm@osdl.org>
	<20050308192900.GA16882@isilmar.linta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>
> compiling -mm2 on my x86 box results in:
> 
> SYSMAP  .tmp_System.map
> Inconsistent kallsyms data
> Try setting CONFIG_KALLSYMS_EXTRA_PASS
> make: *** [vmlinux] Fehler 1
> 
> gcc-Version 3.4.3 20050110 (Gentoo Linux 3.4.3.20050110, ssp-3.4.3.20050110-0, pie-8.7.7)
> 

Did CONFIG_KALLSYMS_EXTRA_PASS fix it up?
