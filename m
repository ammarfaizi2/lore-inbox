Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271341AbTHHNkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271343AbTHHNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:40:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46247 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271341AbTHHNkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:40:23 -0400
Message-ID: <3F33A83A.5030303@pobox.com>
Date: Fri, 08 Aug 2003 09:40:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki-lkm@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4 2/2] add hw_random RNG driver
References: <E19kxq4-0004ou-00@calista.inka.de>
In-Reply-To: <E19kxq4-0004ou-00@calista.inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <20030808025502.GA31909@gtf.org> you wrote:
> 
>>+       bits the RNG circuitry will enter a low power state. Intel will
>>+       provide a binary software driver to give third party software
>>+       access to our RNG for use as a security feature. At this time,
>>+       the RNG is only to be used with a system in an OS-present state.
> 
> 
> this part is confusing, seems it does not apply to linux kernel?

yes, I agree.


>>+       hardware is faulty or has been tampered with).  Data is only
>>+       output if the hardware "has-data" flag is set
> 
> 
> where is the flag coming from, where can one read it? What happens if no
> data is present, will it block?

Correct, it will block.

	Jeff



