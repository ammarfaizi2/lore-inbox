Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264562AbTCZDBb>; Tue, 25 Mar 2003 22:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264563AbTCZDBb>; Tue, 25 Mar 2003 22:01:31 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:37365 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S264562AbTCZDBa>; Tue, 25 Mar 2003 22:01:30 -0500
Message-ID: <3E811A77.3060604@nortelnetworks.com>
Date: Tue, 25 Mar 2003 22:11:51 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Fionn Behrens <fionn@unix-ag.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
Subject: Re: System time warping around real time problem - please help
References: <1048609931.1601.49.camel@rtfm>	 <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>	 <3E80D4CC.4000202@mvista.com>  <1048632934.1355.12.camel@rtfm> <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> If you are using amd76x_pm boot with "notsc", ditto for that matter
> on dual athlons with APM or ACPI in some cases. In fact I wish people
> would stop using the tsc for clock timing altogether. It simply doesn't
> work on a lot of modern systems

But its awfully nice for low-impact high-resolution timestamps.

Maybe someday hardware manufacturers will give us a monotonic GHz+ clock that is 
synced across all cpus and is cheap to read...

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

