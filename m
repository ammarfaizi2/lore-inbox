Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbULJDqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbULJDqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 22:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbULJDqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 22:46:42 -0500
Received: from ms-smtp-03-qfe0.socal.rr.com ([66.75.162.135]:57309 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S261242AbULJDqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 22:46:40 -0500
Message-ID: <41B91C1A.2000502@clones.net>
Date: Thu, 09 Dec 2004 19:46:34 -0800
From: Glendon Gross <gross@clones.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Burning CD's and 2.6.9
References: <Pine.NEB.4.44.0412090810570.27084-100000@bsd.clones.net> <41B87EB4.1080604@dif.dk>
In-Reply-To: <41B87EB4.1080604@dif.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I commented out the "append hdc=ide-scsi" line in /etc/lilo.conf 
and rebooted,
the /dev/hdc device does show up.  I was able to begin burning a CD with 
cdrecord using
cdrecord -v dev=/dev/hdc -audio -pad filename.wav.   However, in the 
middle of the burning
process, I experienced a hard lock up in which the machine did not 
respond to switching virtual consoles with
CTRL+ALT+F2.      This lockup has happened to me twice now, and I am 
still testing to determine if this
is a problem in cdrecord or a linux kernel issue with 2.6.9.

Regards,

Glendon Gross


Jesper Juhl wrote:

> Glendon Gross wrote:
>
>> I just built 2.6.9 and have been playing with the config to try to 
>> enable
>> support for my EMPREX 8x DVD burner.  It works exceptionally well under
>> 2.4.26.   I can use cdrecord and also growisofs to make audio and data
>> DVD's.
>>
> [...]
>
>> I've set up a lilo config menu to boot 2.6.9 or 2.4.26 because the 
>> device
>> is not recognized under 2.6.9.    When it is recognized, I get a warning
>> that ide-scsi is deprecated for cd recording.
>>
> Does it work if you don't use ide-scsi ?
>

