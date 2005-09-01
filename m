Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbVIAWHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbVIAWHD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVIAWHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:07:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030437AbVIAWHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:07:01 -0400
Date: Thu, 1 Sep 2005 15:09:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: tshb@cs.umass.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 freezes during acpi wakup with wake-on-lan
Message-Id: <20050901150925.0d8c53c8.akpm@osdl.org>
In-Reply-To: <43174438.5040704@cs.umass.edu>
References: <43174438.5040704@cs.umass.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas S. Heydt-Benjamin" <tshb@cs.umass.edu> wrote:
>
> I am working with an IBM X31 laptop running Redhat FC5 with 2.6.13
> kernel.  I need to get wake-on-lan working for mobile systems power
> management experiments that we are performing in my lab.
> 
> The kernel is configured to use ACPI (pertinent kernel configuration
> excerpt follows message).
> 
> When I put the laptop into "mem" suspend state (exact procedure follows
> message), and then wake it up with a magic packet to it's NIC, I get an
> infinite number of error messages and a frozen computer.

The ACPI guys have rather a backlog, I'm afraid.  It'd be best if you could
raise a report against ACPI at bugzilla.kernel.org, please.

I don't think you identified the type of NIC, btw.
