Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130847AbRAWXXx>; Tue, 23 Jan 2001 18:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131414AbRAWXXo>; Tue, 23 Jan 2001 18:23:44 -0500
Received: from femail11.sdc1.sfba.home.com ([24.0.95.107]:55805 "EHLO
	femail11.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130847AbRAWXXb>; Tue, 23 Jan 2001 18:23:31 -0500
Message-ID: <3A6E128D.7C436455@pacbell.net>
Date: Tue, 23 Jan 2001 15:23:57 -0800
From: C Sanjayan Rosenmund <gnuman0@pacbell.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Modules not being found with 2.4.0 on a 486 based box
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: me as well, as I'm on to many lists as is. . .

Irecently built 2.4.0 on two diferent x486 PCs and neither of them
recognised the new module directory structure found in the 2.4.x
kernels.  I did not have this problem on the Pentium and better
machines that I built this same kernel on.  I got around the problem
by making a symlink from where the module actually was
(/lib/modules/2.4.0/kernel/drivers/net/) to where the system was
looking for it (/lib/modules/2.4.0/net/) and all is well. . .for now. 
I was wondering if there was any light that could be shed on why this
might happen?  I have only found this to be a problem on 486s,
everything bigger has worked fine.  Details below:
Feature		Working		Not Wotking
Processor	Pentium +	486 (486DX2-66, 486DX-50)
Distrobution	Debian unstable	Debian stable (unstable caused other
problems)
RAM		16Mb +		16Mb +
Hdd size	1Gb +		540Mb +
Modules involved Any		network cards (that is all I was using)

More info can be provided if needed.  This is low priority, I was
wondering if you had any ideas why (or how to get around it, other
than my solution).

Thank you all for your time, and for producing a kernel that is worth
all this work <grin>.

-- 
C Sanjayan Rosenmund
gnuman0@pacbell.net       ICQ 95669689
It is dangerous to be right when the government is wrong. - Voltaire
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
