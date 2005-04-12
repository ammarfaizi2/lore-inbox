Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbVDLUpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVDLUpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVDLUpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:45:00 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:7508 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262965AbVDLUZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:25:03 -0400
Message-ID: <425C2E20.30307@cogent.ca>
Date: Tue, 12 Apr 2005 16:22:56 -0400
From: Andrew Thomas <Andrew.Thomas@cogent.ca>
Organization: Cogent Real-Time Systems Inc.
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: oops in misc_register, kernel 2.6.9+, using udev
References: <42555993.4020108@cogent.ca>
In-Reply-To: <42555993.4020108@cogent.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Thomas wrote:
> Hello,
> 
> I am trying to install the srripc module - source at:
>     http://www.cogent.ca/Software/SRR.html
> on a Linux 2.6.x kernel with udev support.  The kernel generates an oops
> in misc_register, which is essentially the first call that the module
> makes on initialization.  Oops output is attached below.

Sorry, false alarm.  This turned out to be a problem with the makefile 
used to compile the module in 2.6.x.
