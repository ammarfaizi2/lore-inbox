Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTISVr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 17:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTISVr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 17:47:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:27090 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261776AbTISVr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 17:47:27 -0400
Date: Fri, 19 Sep 2003 14:28:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Villacis, Juan" <juan.villacis@intel.com>
Cc: jbarnes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
Message-Id: <20030919142819.1e7155df.akpm@osdl.org>
In-Reply-To: <7F740D512C7C1046AB53446D372001732DEC72@scsmsx402.sc.intel.com>
References: <7F740D512C7C1046AB53446D372001732DEC72@scsmsx402.sc.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Villacis, Juan" <juan.villacis@intel.com> wrote:
>
> > Have you looked into using the infrastructure in drivers/oprofile/ for
> > this?  In other words: is it possible to augment the kernel's existing
> > oprofile capabilities so they meet VTune requirements?
> 
> The current event notifications used by tools like Oprofile, while quite
> useful, are not sufficient.  The additional event notifications we
> propose can provide a more complete picture for performance tuning on
> Linux, particularly for dynamically generated code (such as found in
> Java).  

You are answering a question I did not ask.  Let me rephrase.

Have you considered interfacing vtune userspace to oprofilefs and enhancing
oprofilefs to meet vtune requirements, thus removing the need for the vtune
kernel module, and its device node and ioctl interface?

