Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVCHSTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVCHSTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVCHSTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:19:01 -0500
Received: from peabody.ximian.com ([130.57.169.10]:22940 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261476AbVCHSSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:18:47 -0500
Subject: Re: Question regarding thread_struct
From: Robert Love <rml@novell.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Imanpreet Arora <imanpreet@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <2cd57c9005030810144cfc0b@mail.gmail.com>
References: <c26b959205030809044364b923@mail.gmail.com>
	 <1110302000.23923.14.camel@betsy.boston.ximian.com>
	 <c26b959205030809271b8a5886@mail.gmail.com>
	 <1110302922.28921.3.camel@betsy.boston.ximian.com>
	 <2cd57c9005030810144cfc0b@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 13:12:30 -0500
Message-Id: <1110305551.28921.13.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 02:14 +0800, Coywolf Qi Hunt wrote:

> CONFIG_IRQSTACKS seems only on ppc64. Is it good to add for other archs too?

Some architectures (x86) control per-IRQ stacks via CONFIG_4KSTACKS, so
enabling that directive turns on 4K stacks and gives interrupts their
own stack.

	Robert Love


