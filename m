Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUIWR5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUIWR5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUIWR4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:56:35 -0400
Received: from users.linvision.com ([62.58.92.114]:48606 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S266352AbUIWRzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:55:13 -0400
Date: Thu, 23 Sep 2004 19:55:12 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 2.6.8.1 doesn't boot on x86_64
Message-ID: <20040923175512.GE8101@harddisk-recovery.com>
References: <Pine.LNX.4.44.0409231814500.2275-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409231814500.2275-100000@einstein.homenet>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 06:21:30PM +0100, Tigran Aivazian wrote:
> I haven't heard about it on x86_64 discuss list so I thought it is worth 
> asking if someone else has encountered this. When I boot 2.6.8.1 kernel 
> (patched with kdb) the last thing I see is:
> 
> Freeing unused kernel memory: 160k f
> 
> I don't get the whole word "freed", only the first letter "f". This is SMP 
> kernel. I will try recompiling without kdb and also booting as "nosmp" to 
> see if it makes any difference.
> 
> Fedora Core 2 smp kernel boots fine, btw.

FWIW, a non-kdb patched 2.6.8.1 kernel runs fine on a dual CPU box
(Tyan Thunder K8W with 2x Opteron 242):

Linux zebigbos 2.6.8.1 #1 SMP Fri Sep 10 18:57:48 CEST 2004 x86_64 unknown


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
