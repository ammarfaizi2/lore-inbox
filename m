Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275434AbTHIXM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 19:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275436AbTHIXM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 19:12:26 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:52218 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S275434AbTHIXMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 19:12:23 -0400
Message-ID: <3F358011.7060605@oracle.com>
Date: Sun, 10 Aug 2003 01:13:21 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ruben Puettmann <ruben@puettmann.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10 Problems with radeonfb and suspend mode
References: <20030804181307.GB31178@puettmann.net> <20030809155916.GA28820@puettmann.net>
In-Reply-To: <20030809155916.GA28820@puettmann.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Puettmann wrote:
> On Mon, Aug 04, 2003 at 08:13:07PM +0200,  wrote:
> 
>>        hello,
>>
>>If i load the radeonfb module and send my thinkpad with apm -s to
>>suspend all seems fine but on comming back the screen is still black.
>>
>>Kernel: 2.4.22-pre10 
>>Hardware: Thinkpad R40 2722 / Sony Z1
>>          01:00.0 VGA compatible controller: ATI Technologies Inc 
>>          Radeon Mobility M7 LW [Radeon Mobility 7500]
>>
> 
> 
> Later Tests show that :
> 
> #! /usr/bin/bash
> rmmod radeonfb
> sleep 10
> modprobe radeonfb 
> 
> freeze the laptop. 

Interesting - I sent Ben an Oops I got from rmmod'ing radeonfb
  (same ATI card as yours on a Dell Latitude C640)... but then
  again I have bigger issues with the framebuffer than that :)


Ciao,

--alessandro

  "Prima di non essere sincera / Pensa che ti tradisci solo tu"
       (Vasco Rossi, 'Prima di partire per un lungo viaggio')

