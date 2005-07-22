Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVGVIzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVGVIzU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 04:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVGVIzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 04:55:20 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:8416 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262073AbVGVIzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 04:55:18 -0400
Date: Fri, 22 Jul 2005 10:55:16 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: 10 GB in Opteron machine
Message-Id: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had a working kernel configuration for an Opteron machine. Since that
configuration was supposed to support many kinds of hardware, it
contained many settings that were not optimal for an Opteron machine. So
I created a new configuration especially for that machine. But the
resulting kernel could not be booted. To find the problem I took the
working configuration and changed and it in many small steps and after
every change compiled the kernel, installed it and rebooted to see if
the kernel still boots. 

At last I found out that setting HIGHMEM support to 64 GB is the
problem. But is it really not possible to use more than 4GB on an
Opteron machine?

I have set the processor type to Opteron and disabled SMP support. I am
using Kernel 2.6.11.12.

Christoph 
