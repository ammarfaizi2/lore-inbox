Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTLBN0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTLBN0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:26:36 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:28594 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262128AbTLBN0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:26:35 -0500
Message-ID: <3FCC9307.8050409@wmich.edu>
Date: Tue, 02 Dec 2003 08:26:31 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: ross.alexander@uk.neceur.com
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE-SCSI oops in 2.6.0-test11
References: <OFA87BBFA3.943462EC-ON80256DF0.004502A9-80256DF0.004594B5@uk.neceur.com>
In-Reply-To: <OFA87BBFA3.943462EC-ON80256DF0.004502A9-80256DF0.004594B5@uk.neceur.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ross.alexander@uk.neceur.com wrote:
> CPU: Athlon-XP 2700+
> MB: ASUS A7N8X Deluxe
> Memory: 3 x 512MB
> Notes: UP kernel, standard EIDE driver, boot paramters acpi=off 
> nolapic,noapic
> Libc: glibc-2.3.2 with linuxthreads.
> 
> This error occurs while trying to write a DVD+RW to an NEC-1300A DVD 
> writer
> using cdrecord-dvdpro executable (no source available).  This works fine
> on linux-2.4.23.
> 



First off, acpi should be working just fine now...should have been for 
the last couple versions of 2.6.0-test.
Second, you probably shouldn't be using ide-scsi.  ATAPI works just fine 
using straight ide for CDR's so it probably works fine for DVD-R+R+RW 
whatever stupid acronymn they're using today.
Third, you didn't post the actual oops so how is anyone supposed t osay 
anything about this problem?
Fourth, you are using a binary you didn't compile that's probably 
compiled against headers for api's found in 2.4.x which is seriously 
different from the kernel you're running it on. Compile your own 
cdrecord and see how it goes.

