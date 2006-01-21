Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWAUVjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWAUVjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWAUVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:39:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932380AbWAUVjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:39:15 -0500
Date: Sat, 21 Jan 2006 13:35:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: davej@redhat.com, bunk@stusta.de, linux-kernel@vger.kernel.org,
       pbadari@us.ibm.com, kenneth.w.chen@intel.com
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
Message-Id: <20060121133503.353ad1be.akpm@osdl.org>
In-Reply-To: <1137878739.23974.23.camel@laptopd505.fenrus.org>
References: <20060119030251.GG19398@stusta.de>
	<20060118194103.5c569040.akpm@osdl.org>
	<1137833547.2978.7.camel@laptopd505.fenrus.org>
	<20060121194102.GB28051@redhat.com>
	<20060121131718.1b6bbcdc.akpm@osdl.org>
	<1137878739.23974.23.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> another thing we really should do is making such "obsolete to be phased
>  out" things printk (at least once per boot ;) so that people see it in
>  their logs, not just in the kernel source.

Like sys_bdflush() has been doing for 3-4 years.  That still comes out on
a few of my test boxes, but I'm a distro recidivist.

