Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbTLRFcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 00:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTLRFcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 00:32:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50896 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264391AbTLRFb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 00:31:59 -0500
Message-ID: <3FE13BC3.2000101@pobox.com>
Date: Thu, 18 Dec 2003 00:31:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org> <20031217211516.2c578bab.akpm@osdl.org>
In-Reply-To: <20031217211516.2c578bab.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>Andrew has written up some caveats and pointers to information about 2.4.x
>> vs 2.6.x changes, and I'll let him post that. Some known issues were not
>> considered to be release-critical and a number of them have pending fixes
>> in the -mm queue. Generally they just didn't have the kind of verification
>> yet where I was willing to take them in order to make sure a fair 2.6.0
>> release.
> 
> 
> It's actually rather short because I started late.  See below.
> 
> There are also the "must-fix" and "should-fix" lists of items which we have
> identified as still on the 2.6 todo list.  These are at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/must-fix-7.txt and
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/should-fix-7.txt

Cheers, thanks, and a public salud, boss ;-)


> - Please report any problems to the appropriate mailing list.  If you do
>   not know which list to use, send the report to linux-kernel@vger.kernel.org
>   and it should reach the right person.  Some active subsystem mailing lists
>   are:
> 
> 	linux1394-devel@lists.sourceforge.net
> 	linux-xfs@oss.sgi.com
> 	linux-acpi@intel.com
> 	linux-scsi@vger.kernel.org
> 	ext2-devel@lists.sourceforge.net
> 	linux-usb-users@lists.sourceforge.net

For networking, I request people mail

	netdev@oss.sgi.com


>   Alternatively, kernel bug reports may be entered into the kernel bug
>   tracking system at http://bugme.osdl.org/

I prefer the organization-agnostic

	http://bugzilla.kernel.org/

;-)

FWIW it's more a defense against "osdl.org" domain name changes, than 
anything else...  kernel.org will be around decades from now, IMO.


> - The ATA RAID drivers (eg the HighPoint RAID driver) have not been ported
>   to the new BIO code and are not available under the 2.6 kernel at this
>   time.

These will appear as Device Mapper modules, Arjan has posted.  I'm 
planning on digging my hands into some of that too, now that Promise has 
opened their softRAID spec a bit.

from the #3 networking beaver,

	Jeff



