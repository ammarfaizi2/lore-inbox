Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310528AbSCSJVz>; Tue, 19 Mar 2002 04:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310524AbSCSJVp>; Tue, 19 Mar 2002 04:21:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:54969 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S310516AbSCSJVc>;
	Tue, 19 Mar 2002 04:21:32 -0500
Date: Tue, 19 Mar 2002 10:17:23 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Art Wagner <awagner@westek-systems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 oss modules compile error
In-Reply-To: <3C96ACD1.9010306@westek-systems.com>
Message-ID: <Pine.LNX.4.44.0203191013440.20680-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think I reported that from 2.5.3.

It is the usual virt_to_bus() residuus inside of sound/oss/dm/dmabuf.c

I also posted a wrong patch (was working, but not using the new API), but
maybe someone else posted the right one, and I did not read it.

With this residual virt_to_bus it is quite unusefull that
sound/oss/i810_audio.c and other drivers have been updated correctly.


Luigi

On Tue, 19 Mar 2002, Art Wagner wrote:

> I encountered the attached error whie compiling 2.5.7 with the oss sound
> modules
> configured. The "_not_defined_use_pci_map" portion of the failing statement
> seems to be defined in ./include/asm-i386/io.h, line 117.
> Art Wagner
>

