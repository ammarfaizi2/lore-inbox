Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271283AbUJVMbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271283AbUJVMbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271276AbUJVM2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:28:13 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:19679 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S271271AbUJVMZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:25:44 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098399709.4131.23.camel@krustophenia.net>
References: <1098399709.4131.23.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098444170.19459.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 12:23:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-22 at 00:01, Lee Revell wrote:
> This issue came up on the JACK (http://jackit.sf.net) mailing list. 
> Google was not helpful so I ask here.
> 
> JACK needs to know the CPU speed, in order to calculate the DSP load
> among other things.  It used to be a valid assumption that you could
> calculate it on startup and it would not change.

No it did not. It has never been a safe assumption. Even my old PC110
does APM non-linux assisted shifts between 8 16 and 33Mhz. In addition
there are boxes with dual CPU's and different multipliers - dual 
300/450's were not uncommon.

And thats before we even mention such things at hyped-threading.

