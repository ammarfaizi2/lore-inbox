Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWARDZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWARDZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWARDZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:25:56 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:53646 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932241AbWARDZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:25:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pPpC7dT9by2dj3rwVw9jEhlC6OO8fDsAFHTSuMOu60FWIA4cjLwyr2/Am6vJcjuNlOCUMPUhUlyleX4HpErovM1j55Nc7BBbGrQOPUtp8bbWEE2kJQXbKsekVpSxL+cKboz6S7iF80NUkchKuar4GBUEBXKqoEfCjUEI5A/ipwo=  ;
Message-ID: <43CDB52A.9030103@yahoo.com.au>
Date: Wed, 18 Jan 2006 14:25:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with current linus' git tree
References: <20060116191556.bd3f551c.diegocg@gmail.com>	<43CC7094.9040404@yahoo.com.au> <20060117141725.d80a1221.diegocg@gmail.com>
In-Reply-To: <20060117141725.d80a1221.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Tue, 17 Jan 2006 15:20:36 +1100,
> Nick Piggin <nickpiggin@yahoo.com.au> escribió:
> 

>>What happens if you run several infinite loops to increase the load?
>>Does everything still stay on CPU0?
> 
> 
> Yes, I run several "cat /dev/zero > /dev/null &" and they all kept in
> CPU #0. 
> 
> I did a bitsection search and I couldn't found the culprit, apparently
> it is caused by a config option; now it works fine after switching off
> CONFIG_HOTPLUG_CPU and some ACPI options. Also, when it didn't work
> the CPU that would get all the processes could be CPU #0 or #1 - it
> changed randomly depending on the boot.
> 

If you can report those configuration options and the symptoms in a
new thread to lkml that would be helpful. Also if you can work out
when it started happening, that helps too.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
