Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVBGXAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVBGXAh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 18:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVBGXAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 18:00:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2948 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261344AbVBGW7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:59:41 -0500
Message-ID: <4207F2DA.8060101@us.ibm.com>
Date: Mon, 07 Feb 2005 16:59:38 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Dynids - passing driver data
References: <200502072200.j17M0S0N008552@d01av02.pok.ibm.com> <20050207221820.GA27543@kroah.com> <4207ECDB.7060506@us.ibm.com> <20050207223833.GA2651@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050207223833.GA2651@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Hello!
> 
> 
>>>Which is a good thing, right?  "driver_data" is usually a pointer to
>>>somewhere.  Having userspace specify it would not be a good thing.
>>
>>That depends on the driver usage, and the patch allows it to be 
>>configurable and defaults to not being used.
> 
> 
> Maybe we could just define the operation as cloning of an entry
> for another device ID, including its driver_data.

Possibly. That would potentially require a lot of parameters to 
userspace. We would really need to duplicate all the currently existing 
sysfs parms to accomplish this.

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
