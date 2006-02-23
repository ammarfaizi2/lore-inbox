Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWBWTWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWBWTWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWBWTWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:22:44 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:64469 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1750952AbWBWTWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:22:43 -0500
Message-ID: <43FE0B9A.40209@keyaccess.nl>
Date: Thu, 23 Feb 2006 20:23:06 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>  <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> The same should be true on x86, btw. Where we should use a physical start 
> address of 4MB for best performance.

Does 16MB still work? Gets the kernel out of the old ZONE_DMA. I suppose 
not many people are really using that anyway anymore these days, but if 
no downsides maybe?

Also, did the kernel still boot on a 4M machine, and would it still do 
so with the change to 4M as posted? 2.4 used to boot fine with 4M. Not 
certain anymore if I ever tested that with 2.6 (and can't right now).

Rene.
