Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVDFNr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVDFNr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVDFNr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:47:56 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:28819 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262215AbVDFNrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:47:42 -0400
Message-ID: <4253DA4F.2020707@google.com>
Date: Wed, 06 Apr 2005 08:47:11 -0400
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
References: <4252E827.4080807@google.com> <4252FAE6.8080107@osdl.org>
In-Reply-To: <4252FAE6.8080107@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> 
> 
> Is this related (or could it be -- or should it be) at all to the
> current discussion on the linux-pci mailing list
> linux-pci@atrey.karlin.mff.cuni.cz) about "PCI Error Recovery
> API Proposal" ?


I'm not familiar with the proposal, but this is not related to error 
recovery since master aborts are a way of life on the PCI bus and things 
just need to deal.  The only question is how.

> 
>> the master.  This can only happen when the system is heavily loaded.
> 
> 
> or a PCI device isn't playing nicely?

Yes, but at least then you could blame the device in that case.

[ style and grammar comments noted ]

One thing I did fail to mention in my original post is that all of this 
could be done by rc scripts from user space, but that seems unclean to me.

	Ross
