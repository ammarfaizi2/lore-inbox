Return-Path: <linux-kernel-owner+w=401wt.eu-S1751052AbXAPTPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbXAPTPz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbXAPTPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:15:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39238 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbXAPTPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:15:54 -0500
Message-ID: <45AD2439.6000406@zytor.com>
Date: Tue, 16 Jan 2007 11:15:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>	<45AD02FF.605@zytor.com> <m164b6den7.fsf@ebiederm.dsl.xmission.com>	<45AD1AD7.7030804@zytor.com>	<m1ac0iby5q.fsf@ebiederm.dsl.xmission.com>	<45AD2042.9090701@zytor.com> <m164b6bxpz.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m164b6bxpz.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>
>> Agreed.  *Furthermore*, if the number isn't in <linux/sysctl.h> it shouldn't
>> exist anywhere else, either.
> 
> That would be a good habit.  Feel free to send the patches to ensure that
> is so.
> 
> I'm a practical fix it when it is in my way kind of guy ;)

That's fine.  However, I am wondering if there are things in 
<linux/sysctl.h> which really doesn't need architectural numbers, i.e. 
which should be removed from the binary interface.

	-hpa
