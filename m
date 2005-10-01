Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbVJAABx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbVJAABx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 20:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVJAABx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 20:01:53 -0400
Received: from mail.dvmed.net ([216.237.124.58]:137 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030509AbVJAABw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 20:01:52 -0400
Message-ID: <433DD1E3.2080606@pobox.com>
Date: Fri, 30 Sep 2005 20:01:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrew.patterson@hp.com
CC: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Tuikov, Luben" <Luben_Tuikov@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com> <1128105594.10079.109.camel@bluto.andrew>
In-Reply-To: <1128105594.10079.109.camel@bluto.andrew>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Patterson wrote:
> SDI is supposed to be a cross-platform spec, so mandating sysfs would
> not work.  I suggested to the author to use a library like HPAAPI (used
> by Fibre channel), so you could hide OS implementation details.  I am in
> fact working on such a beasty (http://libsdi.berlios.de).  He thinks
> that library solutions tend to not work, because the library version is
> never in synch with the standard/LLDD's. Given Linux vendor lead-times,
> he does have a valid point.

Any kernel interface lib should be like libc or libalsa:  it hides the 
kernel details, however nasty they may be, shielding userspace and apps 
from various changes over time.

	Jeff


