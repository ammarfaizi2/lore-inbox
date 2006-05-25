Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWEYWMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWEYWMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbWEYWMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:12:20 -0400
Received: from agrajag.inprovide.com ([82.153.166.94]:10690 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S1030468AbWEYWMT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:12:19 -0400
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH] Add compile domain
References: <20060525141714.GA31604@skunkworks.cabal.ca>
	<Pine.LNX.4.61.0605252100070.13379@yvahk01.tjqt.qr>
	<44761E38.7050702@mbligh.org>
	<200605252238.37352.s0348365@sms.ed.ac.uk>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Thu, 25 May 2006 23:12:16 +0100
In-Reply-To: <200605252238.37352.s0348365@sms.ed.ac.uk> (Alistair John Strachan's message of "Thu, 25 May 2006 22:38:37 +0100")
Message-ID: <yw1xhd3dwy7z.fsf@agrajag.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:

> On Thursday 25 May 2006 22:14, Martin J. Bligh wrote:
>> > 20:35 mason:/etc # rpm -qf `which hostname`
>> > net-tools-1.60-37
>> > 21:00 mason:/etc # hostname -v
>> > gethostname()=`mason'
>> > mason
>> > 21:00 mason:/etc # hostname --fqdn
>> > mason
>> > 21:00 mason:/etc # domainname
>> > (none)
>> > 21:00 mason:/etc # dnsdomainname
>> >
>> >
>> > Runs Aurora Linux 2.0.
>>
>> Ubuntu does this too:
>>
>> mbligh@flay:~$ hostname
>> flay
>> mbligh@flay:~$ hostname --fqdn
>> localhost.localdomain
>
> I think it's as Lennart suggested. From the man page for /etc/hosts ("man 
> hosts"), it seems to suggest that the format should be:
>
> IP_address canonical_hostname aliases
>
> On Ubuntu and approximately on my system, it's doing:
>
> 127.0.0.1 localhost.localdomain <alias>
>
> But the manpage suggests that "alias" might contain "localhost". On our 
> machines it contains the "name" we assigned the machine.

The /etc/hosts file that was installed with the Slackware that ran on
my first Linux machine contained a comment strongly advising against
associating 127.0.0.1 with the hostname (or anything other than
localhost).  Apparently some programs (which I don't recall) would
break if you did so.  I have followed that advice ever since.

-- 
Måns Rullgård
mru@inprovide.com
