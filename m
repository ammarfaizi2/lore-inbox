Return-Path: <linux-kernel-owner+w=401wt.eu-S1750821AbXAPSfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbXAPSfY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXAPSfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:35:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:47642 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXAPSfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:35:22 -0500
Message-ID: <45AD1AD7.7030804@zytor.com>
Date: Tue, 16 Jan 2007 10:35:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>	<45AD02FF.605@zytor.com> <m164b6den7.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m164b6den7.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
>> I think it would be fair to say that if they're not in <linux/sysctl.h> they're
>> not architectural, but that doesn't resolve the counterpositive (are there
>> sysctls in <linux/sysctl.h> which aren't architectural?  From the looks of it, I
>> would say yes.)  Non-architectural sysctl numbers should not be exported to
>> userspace, and should eventually be rejected by sys_sysctl.
> 
> This last bit doesn't make much sense.  I believe you are saying all sysctl
> numbers should be per architecture.
> 

With "architectural" I mean "guaranteed to be stable" (as opposed to 
"incidental").  Sorry for the confusion.

	-hpa
