Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTDKTdw (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbTDKTdv (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:33:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60566 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261598AbTDKTdt (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:33:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Apr 2003 21:45:30 +0200 (MEST)
Message-Id: <UTC200304111945.h3BJjU409008.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, James.Bottomley@steeleye.com
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       pbadari@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From James.Bottomley@SteelEye.com  Fri Apr 11 21:12:28 2003

    > It is me who wants compatibility as far as 8+8 device numbers are
    > concerned, while I can see lots of ways to use new number space.

    This, I'm not too sure about.  I see the value to kernel developers who
    boot between different versions of the kernel, but I think when 2.6 goes
    live and ships to end users, it's better not to have such numeric
    equivalency crufting up the SCSI interfaces.

I think compatibility is very important.
Linux does not arbitrarily break old systems. The aim must be
to have all combinations of (old/new) kernel with (old/new) glibc
to work well in all situations where old kernel + old glibc worked.

Andries


