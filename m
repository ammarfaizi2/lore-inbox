Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWEQRaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWEQRaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWEQRaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:30:03 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:20902 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750770AbWEQRaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:30:01 -0400
Message-ID: <446B5DAA.8020004@cmu.edu>
Date: Wed, 17 May 2006 13:30:18 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       linux-lvm@redhat.com
Subject: Re: need help booting from SATA in 2.4.32 / LVM
References: <446A36B8.1060707@cmu.edu> <20060516203917.GQ11191@w.ods.org> <446A418E.3070307@cmu.edu> <20060517034814.GA25818@w.ods.org> <446B2523.1040800@cmu.edu> <20060517133456.GD23933@csclub.uwaterloo.ca> <446B27E4.7040509@cmu.edu> <20060517155335.GF23933@csclub.uwaterloo.ca>
In-Reply-To: <20060517155335.GF23933@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lennart Sorensen wrote:
> On Wed, May 17, 2006 at 09:40:52AM -0400, George Nychis wrote:
>> Because it does......
>>
>> on bootup the *same* exact drive in 2.4.32 shows up as /dev/hda
>>
>> It has the exact same volume information as my drive that shows up in
>> 2.6.9 as /dev/sda
> 
> Yes I do remember a few sata controllers had some support in 2.4, which
> was dropped from 2.6 early on when libata came in.
> 
> It is very unlikely you will ever see that again in the future.
> 
> Len Sorensen
> 

I see... well I am finally getting it to boot, i did not have initrd
support built into the 2.4.32 kernel, but now i'm getting LVM errors:

Scanning logical volumes
   /bin/vgscan.lvm1: execvp failed: No such file or directory
ERROR: /bin/vgscan exited abnormally!
Activating logical volumes
   /bin/vgchange.lvm1: execvp failed: No such file or directory
ERROR: /bin/vgchange exited abnormally!

I know nothing about LVM so... i'm pretty clueless for now
