Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270103AbTGPDam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 23:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270104AbTGPDam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 23:30:42 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:63250 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270103AbTGPDal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 23:30:41 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Wed, 16 Jul 2003 11:16:21 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307151734.46616.mflt1@micrologica.com.hk> <200307160009.08605.mflt1@micrologica.com.hk>
In-Reply-To: <200307160009.08605.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307161110.50725.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 July 2003 00:09, Michael Frank wrote:
> Should we save all registers? - it has 128

Did that, no effect, the controller remains inaccessible

>
> It sits on the same bus with ide, e100 which work, so it won't
> be pci related - OK?.

Tested the driver by unloading/reloading it several times.
Before resume OK. After resume the controller is inaccessible as if "removed"

What other state info could have been lost?

Others: There is no matching kfree for the kmalloc of the socket


Regards
Michael

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

