Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTLSJZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 04:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTLSJZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 04:25:16 -0500
Received: from relay5.ftech.net ([195.200.0.100]:48809 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id S262110AbTLSJZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 04:25:10 -0500
Message-ID: <7C078C66B7752B438B88E11E5E20E72E25CB33@general.hq.farsitecommunications.com>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Samuel Flory'" <sflory@rackable.com>,
       "Chandler, Neville" <chandler@ibiquity.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: non-SMP kernels fail to compile
Date: Fri, 19 Dec 2003 09:25:08 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I seem to recall this problem from a long time ago.
As I remember, doing a make mrproper before starting the Non-SMTP build
solved the problem for me.
Remember to save your .config file outside of the Kernel tree as make
mrproper will delete it.


Kevin

-----Original Message-----
From: Samuel Flory [mailto:sflory@rackable.com] 
Sent: 18 December 2003 23:21
To: Chandler, Neville
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-SMP kernels fail to compile


Chandler, Neville wrote:
> Hello,
>  
> I'm having problems compiling Non-SMP versions of the linux kernel.
> linux-2.4.23 and linux-2.4.24-pre1 fail to compile with SMP disabled.
> However, they do compile cleanly when SMP is enabled. Any help would be
> appreciated.
> 
> Thanks.
> 
> System: Redhat 9
> GCC:    3.3.2
> 
> 


   I've compiled a number of up kernel for 2.4.23 with no issue.  What 
sort of compile errors are you getting?  Can we get you config file.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
