Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161459AbWI2HJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161459AbWI2HJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161461AbWI2HJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:09:04 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:51623 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1161459AbWI2HJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:09:02 -0400
Message-Id: <451CE2F0.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 29 Sep 2006 09:10:08 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Tilman Schmidt" <tilman@imap.cc>, "Andi Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc>	<20060924145337.ae152efd.akpm@osdl.org>	<451BFFA9.4030000@imap.cc>	<200609281912.01858.ak@suse.de>	<451C58AC.5060601@imap.cc>
 <20060928163046.055b3ce0.rdunlap@xenotime.net><20060928163046.055b3ce0.rdunlap@xenotime.net>
 <451C65A0.1080002@imap.cc>
In-Reply-To: <451C65A0.1080002@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's nothing stack trace/unwind related among the functions listed at all afaics.
I don't know much about how profiling works, is it perhaps just missing something?
 Jan

>>> Tilman Schmidt <tilman@imap.cc> 29.09.06 02:15 >>>
Am 29.09.2006 01:30 schrieb Randy Dunlap:
> On Fri, 29 Sep 2006 01:20:12 +0200 Tilman Schmidt wrote:
>> Am 28.09.2006 19:12 schrieb Andi Kleen:
>>>
>>> Can you perhaps boot with profile=1 and then send readprofile output after
>>> boot?
>> I'm afraid I'll need instructions for that. I assume "profile=1"
>> is to be appended to the kernel command line; but how do I
>> retrieve that readprofile output you are asking for?
> 
> Use 'readprofile'.  Usage is described in
> Documentation/basic_profiling.txt in the kernel source tree.

Thanks. Result attached.

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc 
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)
