Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVDEQ0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVDEQ0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDEQ0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:26:05 -0400
Received: from palrel12.hp.com ([156.153.255.237]:30604 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261796AbVDEQWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:22:41 -0400
Message-Id: <200504051632.WAA05569@harvest.india.hp.com>
From: "Amanulla G" <amanulla@india.hp.com>
To: "'Arjan van de Ven'" <arjan@infradead.org>, <linux-kernel@vger.kernel.org>
Cc: <jdp@india.hp.com>
Subject: RE: /proc on 2.4.21 & 2.6 kernels....
Date: Tue, 5 Apr 2005 21:52:32 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1112714309.6275.68.camel@laptopd505.fenrus.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcU59efhOO0eRVh7SNuu4IjjFQQDYwABIMDA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi, 
Thanks for the mail.
May be I didn't put my question correctly.
On 2.4.21 based kernels /proc has got hidden directories which has got the
thread related statistics.
1) /proc/pid reflects resource usage of the process
2) /proc/.pid  (I Was referring to this as a thread ID). Kernel stores
thread resource utilization under this directory.

My question was resource utilization (say cpu utilization) statistics under
/proc/pid doesn't include resource utilization of threads which that process
has created.

May be this is specific to Red Hat AS 3.0 only. I will check it.

My second part of question was:
On 2.6 kernels, we have  /proc/<tgid>/task/xxx 
My question is /proc/<tgid> stats reflect resource utilization of the
threads it has created? 
Or do they only report resource utilization of a process with <tgid> as the
pid? 

Once again thanks for your reply and time.

Thanks & Best Regards,
Amanulla




-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Tuesday, April 05, 2005 8:48 PM
To: Amanulla G
Cc: linux-kernel@vger.kernel.org; jdp@india.hp.com
Subject: Re: /proc on 2.4.21 & 2.6 kernels....

On Tue, 2005-04-05 at 20:41 +0530, Amanulla G wrote:
>  Hi, 
> I would like to know the information on /proc under 2.4.21 based kernels.
>  
> On 2.4.21 based kernels, /proc has got two types of entries.
> /proc/pid & /proc/.tid

2.4 kernels do not have /proc/.tid.

Some vendor kernels might, if you ahve problems with such kernels you
are much better of contacting the vendor of such a kernel instead.




