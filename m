Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUCDEGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbUCDEGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:06:33 -0500
Received: from mail.naturesoft.net ([203.145.184.221]:42163 "EHLO
	naturesoft.net") by vger.kernel.org with ESMTP id S261444AbUCDEGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:06:01 -0500
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: Tim Bird <tim.bird@am.sony.com>, Billy Rose <billyrose@cox-internet.com>
Subject: Re: kernel mode console
Date: Thu, 4 Mar 2004 09:42:22 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200403022152.06950.billyrose@cox-internet.com> <40460C8E.4010100@am.sony.com>
In-Reply-To: <40460C8E.4010100@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403040942.23176.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> set up a remote debug session just to poke around in the kernel.
> Remote debug setup is complex and often fragile.

There is framework called "Kprobes" available, which may
be of use in the cases were remote debugging is a no-no.

After you have applied the kprobes patch, you can put probes
at different portions of the kernel and can dump registers
variables etc.

More details can be found at  
http://www-124.ibm.com/linux/projects/kprobes.


Regards,
KK.
-- 
HomePage: http://puggy.symonds.net/~krishnakumar


