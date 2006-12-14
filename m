Return-Path: <linux-kernel-owner+w=401wt.eu-S1751774AbWLNXOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWLNXOY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWLNXOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:14:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51124 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbWLNXOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:14:23 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4581DAB0.2060505@s5r6.in-berlin.de>
Date: Fri, 15 Dec 2006 00:13:52 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Zach Brown <zach.brown@oracle.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain> <2F8F687E-C5E5-4F7D-9585-97DA97AE1376@oracle.com> <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612141721580.10217@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Thu, 14 Dec 2006, Zach Brown wrote:
...
>> Indeed, there seems to be lots of potential clean-up there.
>> Including duplicate macros like:
>>
>> ./drivers/ide/ide-cd.h:#define ARY_LEN(a) ((sizeof(a) / sizeof(a[0])))
> 
> not surprisingly, i have a script "arraysize.sh":
...

This could also come in the flavor "sizeof(a) / sizeof(*a)".
I haven't checked if there are actual instances.
-- 
Stefan Richter
-=====-=-==- ==-- -====
http://arcgraph.de/sr/
