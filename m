Return-Path: <linux-kernel-owner+w=401wt.eu-S932118AbXAITpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbXAITpw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbXAITpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:45:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:41572 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbXAITpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:45:50 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="183221341:sNHT21534338"
Message-ID: <45A3F0EC.3040404@intel.com>
Date: Tue, 09 Jan 2007 11:45:48 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: Krzysztof Halasa <khc@pm.waw.pl>, Auke Kok <auke-jan.h.kok@intel.com>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH -MM] e1000: rewrite hardware initialization code
References: <45A3D29D.1000202@intel.com>	<m3fyakau44.fsf@defiant.localdomain> <20070109112416.266efb84.randy.dunlap@oracle.com>
In-Reply-To: <20070109112416.266efb84.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2007 19:45:49.0910 (UTC) FILETIME=[C3A4AF60:01C73426]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Tue, 09 Jan 2007 20:16:27 +0100 Krzysztof Halasa wrote:
> 
>> Auke Kok <auke-jan.h.kok@intel.com> writes:
>>
>>>  drivers/net/e1000/Makefile            |   19
>>>  drivers/net/e1000/e1000.h             |   95
>>>  drivers/net/e1000/e1000_80003es2lan.c | 1330 +++++
>>>  drivers/net/e1000/e1000_80003es2lan.h |   89
>>>  drivers/net/e1000/e1000_82540.c       |  586 ++
>>>  drivers/net/e1000/e1000_82541.c       | 1164 ++++
>>>  drivers/net/e1000/e1000_82541.h       |   86
>>>  drivers/net/e1000/e1000_82542.c       |  466 ++
>>>  drivers/net/e1000/e1000_82543.c       | 1397 +++++
>>>  drivers/net/e1000/e1000_82543.h       |   45
>>>  drivers/net/e1000/e1000_82571.c       | 1132 ++++
>>>  drivers/net/e1000/e1000_82571.h       |   42
>> Perhaps the "e1000_" prefix could be dropped as redundant?
>> -- 
> 
> Yes, that suggestion would agree with what Linus told us about
> usb file names 7 years ago.  (huh?  that long?)


You'll have to excuse me that I don't remember that anymore, but I'll note the 
suggestion and see what the team thinks.

Thanks,

Auke
