Return-Path: <linux-kernel-owner+w=401wt.eu-S1753782AbWLWV54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbWLWV54 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 16:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbWLWV5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 16:57:55 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:36006 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbWLWV5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 16:57:55 -0500
Date: Sat, 23 Dec 2006 22:57:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Patrick McHardy <kaber@trash.net>
cc: Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: xt_request_find_match
In-Reply-To: <4588FF92.9050607@trash.net>
Message-ID: <Pine.LNX.4.61.0612232254110.10087@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0612161851180.30896@yvahk01.tjqt.qr>
 <4587D227.1000003@trash.net> <Pine.LNX.4.61.0612191405160.24179@yvahk01.tjqt.qr>
 <4587E91A.2020903@trash.net> <Pine.LNX.4.61.0612191623490.10396@yvahk01.tjqt.qr>
 <4588F175.8060109@trash.net> <Pine.LNX.4.61.0612201009540.26276@yvahk01.tjqt.qr>
 <4588FF92.9050607@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 20 2006 10:17, Patrick McHardy wrote:
>Jan Engelhardt wrote:
>>>Make sure the user specifies the match on the command line before
>>>your match. Look at the TCPMSS or REJECT targets for examples for
>>>this.
>> 
>> That would mean I'd have to
>> 
>>   -p tcp -m multiport --dport 1,2,3,4 -m time --time sundays -m 
>> lotsofothers -j TARGET
>>   -p udp -m multiport --dport 1,2,3,4 -m time --time sundays -m 
>> lotsofothers -j TARGET
>
>I don't see any match that would depend on an other match in
>your example. How about your start explaining what you would
>like to do, ideally with some code.

Yup, on the spot!
http://jengelh.hopto.org/f/chaostables/chaostables-0.1.tar.bz2
(Contains a target, but still something that could use 
xt_request_find_module.)


	-`J'
-- 
