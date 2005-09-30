Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVI3S3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVI3S3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVI3S3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:29:08 -0400
Received: from 216-54-166-16.gen.twtelecom.net ([216.54.166.16]:61653 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S964917AbVI3S3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:29:07 -0400
Message-ID: <433D83EF.8090501@compro.net>
Date: Fri, 30 Sep 2005 14:29:03 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Opterons and setting the pci bus master bit
References: <433D71A0.1040104@compro.net> <1128104342.17099.67.camel@localhost.localdomain>
In-Reply-To: <1128104342.17099.67.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.30.19
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='IP_HTTP_ADDR 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2005-09-30 at 13:10 -0400, Mark Hounschell wrote:
>>everything is fine. When we connect the same chassis to an Intel P4 box 
>>everything is fine. It looks like it is the kernel that sets this bit 
>>because we have never set it in any of our drivers, yet on the intel 
>>boxes it gets set. Why would this bit not be set when the chassis is 
>>connected to an Opteron. We are running 32-bit mode BTW. I am using a 
>>2.6.11.9 kernel. Is this a motherboard problem or could this be a kernel 
>>problem?
> 
> If your device needs to bus master you need to call
> pci_set_master(pci_dev). The bus mastering setup prior to that really
> depends on the BIOS and phase of the moon.
> 
> See Documentation/pci.txt
> 
> Alan
> 
> 

Ok, thats what I'll do then.

Thanks for the info.
Mark



