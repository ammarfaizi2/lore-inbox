Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbUAZKeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 05:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUAZKeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 05:34:04 -0500
Received: from relay.inway.cz ([212.24.128.3]:25324 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S265567AbUAZKd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 05:33:59 -0500
Message-ID: <4014ECE1.1090602@scssoft.com>
Date: Mon, 26 Jan 2004 11:33:05 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.x] e1000: NETDEV WATCHDOG: eth0: transmit timed out
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229D92@orsmsx402.jf.intel.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102229D92@orsmsx402.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:

>>since we have upgraded cabling on our network and transfer 
>>speeds increased a little bit, we are experiencing very often 
>>situations where the Intel PRO/1000 nics just stop responding 
>>and network dies for a while. Local console works, there are 
>>no more error messages other than (when the eth0 comes to a 
>>life again):
>>
>>NETDEV WATCHDOG: eth0: transmit timed out
>>e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
>>    
>>
>
>Petr, I need you to try something.  Get ethtool 1.8
>(sf.net/projects/gkernel) and turn off TSO:
>
>  # ethtool -K eth0 tso off
>
>If you now longer see NETDEV WATCHDOG's, I have a next step.  More on
>that later.
>
>-scott
>  
>
Scott,

after a weekend and half of working day (with extra torturing of the 
network card)
the NETDEV WATCHDOG's are not barking anymore with the tso's disabled.

Do you want me to do more testing or will you tell me what _the_ next 
step is ? :-)

Regards,
Petr

