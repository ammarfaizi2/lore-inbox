Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbULPBgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbULPBgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbULPBSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:18:17 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35713 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262567AbULPAvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:51:22 -0500
Subject: Re: No Subject
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Steven.Hand@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       riel@redhat.com
In-Reply-To: <41BF1983.mailP9C1B91GB@suse.de>
References: <41BF1983.mailP9C1B91GB@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103154617.3585.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Dec 2004 23:50:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen interface seems to me better described that most of the kernel
interfaces and has more papers written on it. I would rather see
arch/xen and public exposure and use of the platform before considering
major redesigns. The s390 people have proved we can remove/fold arch
directories effectively and after original implementation without
problems.

I'm not convinced by your arguments about arch/xen although I am long
term in favour because I'd like see it easy to build a kernel which can
be used without Xen and can switch into Xen guest mode on Xen loading.

Alan

