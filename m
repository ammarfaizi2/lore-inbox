Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWBLSHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWBLSHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWBLSHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:07:47 -0500
Received: from smtpout.mac.com ([17.250.248.89]:42721 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751055AbWBLSHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:07:46 -0500
In-Reply-To: <1139244412.10437.32.camel@localhost.localdomain>
References: <1139244412.10437.32.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <77EB4D57-E152-4F29-ACCF-842FE2F7A151@mac.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: libATA  PATA status report, new patch
Date: Sun, 12 Feb 2006 13:07:39 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 06, 2006, at 11:46, Alan Cox wrote:
> With the exception of HPA and serialize support its now pretty  
> close to a straight replacement for drivers/ide on x86 systems (and  
> boxes using PCI devices only). There is other stuff that wants  
> improving still like error recovery on CRC, but its getting close.
>
> Please remember that functionality equivalence, and much cleaner  
> code doesn't mean less bugs yet, there is a *lot* of testing and  
> hammering on the code needed before it is production ready for  
> switching.

 From looking at your status file, I can't tell if you've implemented  
the PowerMac IDE support yet (Based on your email's mention of x86- 
only, I'm guessing not).  If/when you do get that support done, I'd  
be more than happy to test it for you on my PPC boxen.  Overall this  
work looks very nice, thanks!

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


