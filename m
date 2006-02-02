Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWBBFMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWBBFMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbWBBFMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:12:35 -0500
Received: from smtpout.mac.com ([17.250.248.88]:24290 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161119AbWBBFMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:12:34 -0500
X-PGP-Universal: processed;
	by AlPB on Wed, 01 Feb 2006 23:12:19 -0600
In-Reply-To: <43E0F73B.6040507@pobox.com>
References: <200602010609.k1169QDX017012@hera.kernel.org> <43E0F73B.6040507@pobox.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A9543B03-333E-470F-AD18-0313192ADB23@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: [PATCH] PCI: restore 2 missing pci ids
Date: Wed, 1 Feb 2006 23:11:36 -0600
To: Jeff Garzik <jgarzik@pobox.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

On Feb 1, 2006, at 12:00 PM, Jeff Garzik wrote:

> Linux Kernel Mailing List wrote:
>> tree e425ac74afc0b89f3a513290a2dd5e503d974906
>> parent 654143ee3a73b2793350b039a135d9cd3101147b
>> author Mark Rustad <MRustad@mac.com> Fri, 06 Jan 2006 14:47:29 -0800
>> committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 01 Feb 2006  
>> 10:00:11 -0800
>> [PATCH] PCI: restore 2 missing pci ids
>> Somewhere between 2.6.14 and 2.6.15-rc3, some PCI ids were apparently
>> removed.  The ecc.c module, which is not a part of the kernel.org  
>> tree, but
>> included in some distributions, fails to compile.
>> Signed-off-by: Mark Rustad <mrustad@mac.com>
>> Signed-off-by: Andrew Morton <akpm@osdl.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>>  include/linux/pci_ids.h |    2 ++
>>  1 files changed, 2 insertions(+)
>
> Why was this applied?  We could apply these patches all day, and  
> get nothing else done.  If it's not in the kernel tree, we  
> shouldn't be worrying about it.  Let the distros patch it in.

Well, I offered the patch because I found that I suddenly needed it.  
I did not know why the ids had been removed, but it looks to me like  
edac is coming right along and will need the ids itself, so I sent  
the patch off.

Frankly, I was surprised that the patch was so quickly accepted. I  
perceive some difference of opinion on how PCI ids should be handled.  
Is there a consensus on a better way to handle ids? Why were the ids  
removed in the first place? THAT was worse than wasted effort.

-- 
Mark Rustad, MRustad@mac.com

