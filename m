Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSKMSmV>; Wed, 13 Nov 2002 13:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSKMSmV>; Wed, 13 Nov 2002 13:42:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23792 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262418AbSKMSmS>;
	Wed, 13 Nov 2002 13:42:18 -0500
Message-ID: <3DD29E8B.496550A6@mvista.com>
Date: Wed, 13 Nov 2002 10:48:43 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Lynch <rusty@linux.co.intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How can I verify a memory address exist?
References: <000b01c28aa8$ac0235c0$77d40a0a@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Lynch wrote:
> 
> Is there a kernel function to find out if a given memory address exist?
> 
>     -rustyl

Here is a related question.  Is there a way to verify that
an address is a valid slab sub space address?  I.e. that it
was allocated by slab for a particular usage and is still
valid (i.e. has not been returned). 
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
