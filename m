Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUEFPqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUEFPqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUEFPqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:46:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262744AbUEFPp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:45:58 -0400
Message-ID: <409A5DA6.4020801@pobox.com>
Date: Thu, 06 May 2004 11:45:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: mj@ucw.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: PCI devices with no PCI_CACHE_LINE_SIZE implemented
References: <20040506132810.GB13482@lists.us.dell.com>
In-Reply-To: <20040506132810.GB13482@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> Martin, below is a patch to lower the severity of this printk to
> KERN_DEBUG, as there are devices which (properly) don't implement the
> PCI_CACHE_LINE_SIZE register, and it's not a bug, so don't print at a
> WARNING level.
> 
> Thanks,
> Matt

I'd send it straight to Marcelo, saying that the 2.6 PCI maintainer 
approved it....  Martin hasn't hacked on kernel code in a while...

	Jeff




