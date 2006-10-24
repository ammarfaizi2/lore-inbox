Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWJXAFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWJXAFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 20:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWJXAFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 20:05:01 -0400
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:21984 "EHLO
	smtp121.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S932349AbWJXAFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 20:05:00 -0400
Message-ID: <453D5870.20308@gentoo.org>
Date: Mon, 23 Oct 2006 20:04:00 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Udo van den Heuvel <udovdh@xs4all.nl>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: sata_via issue for VIA Epia SP8000 in 2.6.18[.1]?
References: <453B61D9.9060707@xs4all.nl>
In-Reply-To: <453B61D9.9060707@xs4all.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo van den Heuvel wrote:
> Hello,
> 
> 2.6.17.13 works OK on this VIA Epia SP8000.
> (remember vaguely about some (PCI?) fixups to get things going)
> Now I try to get 2.6.18.1 working. SATA is detected by this kernel but
> disk gives timeout while 2.6.17.13 boots fine.
> 
> Some burbs:
> 
> Links is up but  SStatus 113 SControl 300
> qc timeout (cmd 0xec)
> failed to IDENTIFY
> This results in a kernel panic.

Try this patch:
http://marc.theaimsgroup.com/?l=git-commits-head&m=116121959622812&q=raw

If that doesn't help, I guess you're seeing the same as 
https://bugs.gentoo.org/150773

Daniel


