Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVDNAGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVDNAGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDNAEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:04:08 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:29347 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261236AbVDNADP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:03:15 -0400
From: "Bernd Schubert" <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Date: Thu, 14 Apr 2005 02:03:07 +0200
To: Bradley Reed <bradreed1@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDR read problems with 2.6.11?
Message-ID: <20050414000307.GA15733@tc.pci.uni-heidelberg.de>
References: <20050414013619.342cea4e@galactus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414013619.342cea4e@galactus.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> 
> root@galactus:~[1009]# mount /mnt/cdrom
> mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
>        missing codepage or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
>        

[...]

> The drive is a NEC DVD+RW ND-5100A
> 
> Any suggestions on why I can't read (or burn correctly) the disks with 2.6.11?
>

I have seen exactly the same on my fathers computer and could solve this
by not starting the udftools. Didn't have the time to digg further into
this... 
Can you confirm thats really a udf problem? Just run
"/etc/init.d/udftools stop" or the similar for your distribution and try
mounting again.

Cheers,
	Bernd
