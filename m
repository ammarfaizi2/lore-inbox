Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVAMFBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVAMFBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVAMFBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:01:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:5567 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261506AbVAMFBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:01:46 -0500
Message-ID: <41E5FF0C.10807@osdl.org>
Date: Wed, 12 Jan 2005 20:54:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: selvakumar nagendran <kernelselva@yahoo.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: exporting /proc entry for module
References: <20050113044912.40078.qmail@web60610.mail.yahoo.com>
In-Reply-To: <20050113044912.40078.qmail@web60610.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

selvakumar nagendran wrote:
> --- Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> 
>>To fix this in the future, export a /proc entry that
>>when written to 
>>causes your module to properly clean everything up
>>and prevent anyone 
>>from getting new accesses.  This then allows you to
>>remove the module 
>>cleanly.  Note that it may not be possible to
>>cleanly deregister, 
>>depending on what your module is doing.
>>
> 
>   How can I export a /proc entry for my module?

. . . . . . . . . .

You can study the valuable documents at
http://kernelnewbies.org/documents/

or google for other procfs example source code,
which should find several examples for you,
such as http://www.xenotime.net/linux/procfs_ex/

-- 
~Randy
