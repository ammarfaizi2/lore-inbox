Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVLLIHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVLLIHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVLLIHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:07:34 -0500
Received: from [202.125.80.34] ([202.125.80.34]:12263 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1751126AbVLLIHe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:07:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Errors while booting the newly built 2.6.12 kernel??
Date: Mon, 12 Dec 2005 13:28:46 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B1BDB03@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Errors while booting the newly built 2.6.12 kernel??
Thread-Index: AcX+7IM2MYpUVGbfSsKCULm9uVUwNQAAHTpw
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Arjun,
Thanks for your quick response
After I compiled the kernel, I verified the 'initrd-2.6.12.img' and it was present. 
But it is 10000 bytes less than the initial FC4 initrd img.

I did the following steps to build the kernel:

Copied the existing '.config' file from the old kernel and copied to the 2.6.12 kernel base directory.
Then,
# make
# make modules
# make modules_install
# make install

Is there is any thing additional needed for building the kernels in 2.6.x kernels?
I verified the support for inbuilt ext3 too and its present too.
What else could be the problem area?

Thanks & Regards,
Mukund Jampala


-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org]
Sent: Monday, December 12, 2005 12:54 PM
To: Mukund JB.
Cc: linux-kernel@vger.kernel.org
Subject: Re: Errors while booting the newly built 2.6.12 kernel??


On Mon, 2005-12-12 at 12:44 +0530, Mukund JB. wrote:
> Dear Kernel Team,
> 
> I am facing a strange error after I compiled the Linux kernel-2.6.12(downloaded from kernel.org).
> Please see the errors I get when I try to boot the newly built 2.6.12 kernel.
> 
> I found lot of members in the groups discussing this and no definite solution is suggestion.

you forgot to make an initrd.


