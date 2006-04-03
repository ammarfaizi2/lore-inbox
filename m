Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWDCMCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWDCMCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWDCMCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:02:18 -0400
Received: from [212.33.185.14] ([212.33.185.14]:38928 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S964838AbWDCMCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:02:17 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Mon, 3 Apr 2006 14:59:51 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200604031459.51542.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Peter Williams wrote:
> > Peter Williams wrote:
>
> Now available for 2.6.16 at:

Thanks a lot!

> >> You can select a default scheduler at kernel build time.  If you wish
> >> to boot with a scheduler other than the default it can be selected at
> >> boot time by adding:
> >>
> >> cpusched=<scheduler>

Can this be made runtime selectable/loadable, akin to iosched?

> >> Control parameters for the scheduler can be read/set via files in:
> >>
> >> /sys/cpusched/<scheduler>/

The default values for spa make it really easy to lock up the system.
Is there a module to autotune these values according to cpu/mem/ctxt 
performance?

Also, different schedulers per cpu could be rather useful.

Thanks!

--
Al

