Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263262AbUJ2L2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbUJ2L2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbUJ2L2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:28:04 -0400
Received: from alog0368.analogic.com ([208.224.222.144]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263262AbUJ2L1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:27:54 -0400
Date: Fri, 29 Oct 2004 07:24:43 -0400 (EDT)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Kahro Raie <kahroo@hot.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: ERROR: Disabling IRQ #11
In-Reply-To: <20041029062746.B69E312CE@portal.hot.ee>
Message-ID: <Pine.LNX.4.61.0410290721530.11692@chaos.analogic.com>
References: <20041029062746.B69E312CE@portal.hot.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Kahro Raie wrote:

> Description:
> After my system has been up for about 10 minutes I allways get
> the following 2 line error message on every console:
> Message from syslogd@etna at Fri Oct 29 08:46:55 2004 ...
> etna kernel: Disabling IRQ #11
>

Find the driver (module) that is using IRQ11. That module is
probably not returning the correct value from its ISR. That's
one of the changes in new kernels. ISRs now have to return values.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
