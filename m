Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbVIOHOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVIOHOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVIOHOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:14:05 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:15075 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030361AbVIOHOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:14:02 -0400
Message-ID: <43291F77.6000505@aitel.hist.no>
Date: Thu, 15 Sep 2005 09:15:03 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: chriswhite@gentoo.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Quick update on latest Linux kernel performance
References: <200509132132.j8DLWJg04553@unix-os.sc.intel.com> <200509141517.38985.chriswhite@gentoo.org> <43284B61.50509@tmr.com>
In-Reply-To: <43284B61.50509@tmr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Chris White wrote:

[...]

>>
>> The benchmarks here have a slight flaw in that the main hardware 
>> components tested are not given.  About the only thing I can see 
>> regarding these tests is what processor they run on.  Displaying 
>> network performance tests without showing the network card or io 
>> tests without showing the disk controller seems rather odd.  I guess 
>> it comes down to requesting a full hardware rundown.  If this is 
>> displayed someplace on the site or elsewhere please provide the link.
>
>
> Unless the hardware was changed, this is not particularly relevant. 
> It's good testing to change only one thing, so you know that's what 
> caused the change in results.

The benchmarks surely says something about the kernel regardless of
wether they specify hardware.  But if you want performance regressions
fixed, then the hardware list is necessary.  It is interesting to know
wether the test machine used SCSI or IDE for IO for example, for those
systems get different patches.  One may regress while another improves.
Similiar for all the different network adapter drivers and so on.

Helge Hafting
