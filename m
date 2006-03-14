Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWCNJgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWCNJgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWCNJgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:36:53 -0500
Received: from toby.tomseeley.co.uk ([194.143.175.75]:24229 "EHLO
	toby.tomseeley.co.uk") by vger.kernel.org with ESMTP
	id S1752046AbWCNJgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:36:52 -0500
Message-ID: <44168E9E.7050503@tomseeley.co.uk>
Date: Tue, 14 Mar 2006 09:36:30 +0000
From: Tom Seeley <redhat@tomseeley.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Avuton Olrich <avuton@gmail.com>, xfs-masters@oss.sgi.com,
       linux-xfs@oss.sgi.com, Dave Jones <davej@redhat.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, norsk5@xmission.com,
       dsp@llnl.gov, bluesmoke-devel@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, pete.chapman@exgate.tek.com,
       Olaf Hering <olh@suse.de>, paulus@samba.org, anton@samba.org,
       linuxppc64-dev@ozlabs.org, laredo@gnu.org,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
Subject: Re: 2.6.16-rc6: known regressions
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de> <E1FIuFC-0004kk-00@decibel.fi.muni.cz>
In-Reply-To: <E1FIuFC-0004kk-00@decibel.fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Greg KH wrote:
>> On Mon, Mar 13, 2006 at 09:05:44PM +0100, Adrian Bunk wrote:
>>> Subject    : Stradis driver udev brekage
>>> References : http://bugzilla.kernel.org/show_bug.cgi?id=6170
>>>              https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
>>>              http://lkml.org/lkml/2006/2/18/204
>>> Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
>>>              Dave Jones <davej@redhat.com>
>>> Handled-By : Jiri Slaby <jirislaby@gmail.com>
>>> Status     : unknown
>> Jiri, why did you create a kernel.org bugzilla bug with almost no
>> information in it?
>>
>> Anyway, this is the first I've heard of this, more information is
>> needed to help track it down.  How about the contents of /sys/class/dvb/ ?
> Hello,
> 
> sorry for that, I expected Tom to help us track this down -- he has this
> problem, but he haven't replied yet. Nobody else is complaining, would we defer
> or close it for now?
> 
> best regards,

Apologies for the lack of additional information, this is simply a lack 
of time on my behalf.  My first attempt to bisect 2.6.15 <-> 2.6.16-rc5 
produced a kernel which caused udev to crash (and stop init).  I will 
shift the goalposts and try again.  Once I have the results I will post 
them to bugzilla.  I will also post the contents of /sys/class/dvb as 
requested above.

Thanks,

Tom.
