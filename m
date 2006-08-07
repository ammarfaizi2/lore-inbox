Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWHGFw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWHGFw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWHGFw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:52:58 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:46150 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750924AbWHGFw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:52:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UqwYnL17o4N4Dbn9Ui6i+aZong/K8Ljh4ao1gfMpRL6kaFjeRV7f3gmdSepV0bAtM8yfZuatwcRnrkYYA9Q9LnzvAuxP7AmhR44DsDYjBoQR4Fec25LcVv25HlLe6mECGHI9BV+qTumkbL/i/iwrrSJMieudRd6nsw3qN77jPr4=
Message-ID: <44D6D511.8060409@gmail.com>
Date: Mon, 07 Aug 2006 14:52:17 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Pavel Roskin <proski@gnu.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace last instances of pci_module_init with pci_register_driver
References: <20060807043154.7901.74081.stgit@dv.roinet.com> <20060807044737.GA20013@kroah.com>
In-Reply-To: <20060807044737.GA20013@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Aug 07, 2006 at 12:31:54AM -0400, Pavel Roskin wrote:
>> From: Pavel Roskin <proski@gnu.org>
>>
>> Signed-off-by: Pavel Roskin <proski@gnu.org>
>> ---
>>
>>  drivers/net/3c59x.c                           |    2 +-
>>  drivers/net/8139cp.c                          |    2 +-
> 
> You are going to have to send this through the network and scsi driver
> maintainers, it's not something that I can apply, sorry.

I'll pick up libata part and push it through Jeff.

Thanks.

-- 
tejun
