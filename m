Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbULIPst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbULIPst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbULIPst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:48:49 -0500
Received: from main.gmane.org ([80.91.229.2]:46003 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261532AbULIPsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:48:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Date: Thu, 09 Dec 2004 10:48:43 -0500
Message-ID: <87oeh35v6s.fsf@coraid.com>
References: <87acsrqval.fsf@coraid.com> <20041206215456.GB10499@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:Qv/HVtbkccNPySi34XAus83ObD8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

...
>> +	printk(KERN_INFO "aoe: aoeblk_ioctl: unknown ioctl %d\n", cmd);
>
> So I can flood the syslog by sending improper ioctls to the driver?
> That's not nice...

Wouldn't root be the only user who could do that?  When would this
happen?  

If it's happening by accident, then something's wrong, and it's
helpful to make it known that something's wrong.  If it's on purpose,
then somebody has root and is doing malicious things, in which case
syslog flooding is the least of our worries.  They could do the same
thing using "logger" anyway.

-- 
  Ed L Cashin <ecashin@coraid.com>

