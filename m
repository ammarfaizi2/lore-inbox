Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161519AbWJVAd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161519AbWJVAd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161521AbWJVAd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:33:28 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:28523 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161519AbWJVAd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:33:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=EB6AbqeG87EboIEUnJcT5t2Hw+f7tyHboC3LL8gVuA73m1h4NXHnkgdXXrW0BRYSanjpvCLTyN/oBW2lqkDvE9DRt1YZrpe/HGk9OkndlBgAhhJkHAFSXiGvb5XnNXZUYvOE7hXQxEAytn844J/yF0b+aohXc5W0CBnUi0Mqdl0=  ;
Message-ID: <453ABC7B.7030405@sbcglobal.net>
Date: Sat, 21 Oct 2006 19:34:03 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>, Greg KH <greg@kroah.com>, akpm@osdl.org
Subject: Re: 2.6.19-rc2-mm2
References: <20061020015641.b4ed72e5.akpm@osdl.org>	<200610201339.49190.m.kozlowski@tuxland.pl>	<20061020091901.71a473e9.akpm@osdl.org>	<200610201854.43893.m.kozlowski@tuxland.pl>	<20061020102520.67b8c2ab.akpm@osdl.org>	<45394F97.9010401@sbcglobal.net> <p734ptybk0z.fsf@verdi.suse.de>
In-Reply-To: <p734ptybk0z.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This time to everybody)
Andi Kleen wrote:
> Matthew Frost <artusemrys@sbcglobal.net> writes:
> 
>> Andrew Morton wrote:
>>
>>> Ow.  Multithreaded probing was probably a bt ambitious, given the current
>>> status of kernel startup..
>>>
>>> Greg, does it actually speed anything up or anything else good?
>>>
>> I'm on a x86 (P4) hi-mem machine, plenty of onboard PCI (audio, LAN, bonus IDE
>> controller, etc.), and it has sped up my boot process.  Between the USB and PCI
>> multithread probing, my dmesg is a bit out of order from its ordinary sequence,
>> but the only things that stall it now are my MD-RAID partitions getting set up.
> 
> Did you measure it?  Feelings and impressions tend to be unreliable.
> 

I'll do some testing apples to apples-with-multithreaded-probing.  Will return
with numbers to see whether it's my subjective impression or really faster.

> -Andi
> 

Matt
