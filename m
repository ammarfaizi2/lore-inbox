Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUJIWBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUJIWBT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 18:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUJIWBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 18:01:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:8365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267497AbUJIWAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 18:00:24 -0400
Message-ID: <41685EBD.500@osdl.org>
Date: Sat, 09 Oct 2004 14:57:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: anil dahiya <ak_ait@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: module profiling
References: <20041009214555.3754.qmail@web60202.mail.yahoo.com>
In-Reply-To: <20041009214555.3754.qmail@web60202.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anil dahiya wrote:
> Hello 
> Plz tell me how to do module profiling on linux kernel
> 2.4.20 ???

Try oprofile (see oprofile.sf.net) or try this patch
for old-school in-kernel profiling:

http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/0950.html

That patch was for 2.4.18.  It was never updated for other
2.4.x versions that I know of.

-- 
~Randy
