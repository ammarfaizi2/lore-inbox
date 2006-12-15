Return-Path: <linux-kernel-owner+w=401wt.eu-S1752601AbWLOOSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbWLOOSu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbWLOOSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:18:50 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:46420 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbWLOOSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:18:50 -0500
Message-ID: <4582AEC8.7030608@s5r6.in-berlin.de>
Date: Fri, 15 Dec 2006 15:18:48 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, jesper.juhl@gmail.com,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH/v2] CodingStyle updates
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> <20061215120942.GA4551@ucw.cz>
In-Reply-To: <20061215120942.GA4551@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>> +Use one space around (on each side of) most binary and ternary operators,
>> +such as any of these:
>> +	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
> 
> Actually, this should not be hard rule. We want to allow
> 
> 	j = 3*i + l<<2;

Which would be very misleading. This expression evaluates to

	j = (((3 * i) + l) << 2);

Binary + precedes <<.
-- 
Stefan Richter
-=====-=-==- ==-- -====
http://arcgraph.de/sr/
