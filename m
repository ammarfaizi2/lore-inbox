Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVABUZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVABUZa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVABUZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:25:30 -0500
Received: from one.firstfloor.org ([213.235.205.2]:23990 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261317AbVABUZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:25:26 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vincent ETIENNE <ve@vetienne.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: AMD64-AGP pb with AGP APERTURE on IWILL DK8N
References: <200412282049.48616.ve@vetienne.net> <m13bxnli1x.fsf@muc.de>
	<1104674059.14712.42.camel@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: Sun, 02 Jan 2005 21:25:25 +0100
In-Reply-To: <1104674059.14712.42.camel@localhost.localdomain> (Alan Cox's
 message of "Sun, 02 Jan 2005 14:36:40 +0000")
Message-ID: <m1r7l3y3wq.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Iau, 2004-12-30 at 19:09, Andi Kleen wrote:
>> Vincent ETIENNE <ve@vetienne.net> writes:
>> There is already code to do this at the end of the function. A better
>> patch would be the attached one.
>> 
>> This would also handle the case of a wrong aper_base.
>> 
>> Untested, uncompiled right now.
>
> Please make the final version complain in printk as well. That helps
> motivate vendors to fix BIOS problems.

The code below complains loudly anyways about a broken aperture.

-Andi
