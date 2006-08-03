Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWHCWO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWHCWO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 18:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWHCWO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 18:14:57 -0400
Received: from main.gmane.org ([80.91.229.2]:36992 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030223AbWHCWO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 18:14:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Backlund <tmb@mandriva.org>
Subject: Re: Kernel Hangs, EIP is at scsi_decide_disposition
Date: Fri, 04 Aug 2006 01:15:07 +0300
Message-ID: <eatsgi$iov$1@sea.gmane.org>
References: <20060803154237.12936.qmail@web51002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ndn243.bob.fi
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
In-Reply-To: <20060803154237.12936.qmail@web51002.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Mollel wrote:
> Our mandriva boxes are randomly crushing after
> migration to 2006.0 download version. The same
> hardware has had mandriva 10.0 withuptimes of over 230
> days....but nowadays it is hardly a week before a
> crash for over 6 nodes with latest kernels.
> 

The correct place to report this is:

http://qa.mandriva.com/


> I captured one of our lockups and am attaching the
> output of ksymoops for further interpretation by mroe
> experienced eyes when it comes to kernel internals.
> 
> Here is the actual error, and attached, the ksymoops
> interpretation of it.
> 
> Unable to handle kernel NULL pointer dereference at
> virtual address 000002a9
>  printing eip:
> f88642bd
> *pde = 3702b001
> Oops: 0000 [#1]
> SMP
> Modules linked in: sg nfsd exportfs raw md5 ipv6 nfs
> lockd nfs_acl sunrpc parport_pc lp parport e1000
> af_packet floppy video thermal tc1100_wmi processor
> fan container button battery ac ipt_LOG ipt_REJECT
> ipt_state ip_conntrack iptable_filter ip_tables ide_cd
> loop hw_random 3w_9xxx tsdev sr_mod ehci_hcd uhci_hcd
> usbcore evdev reiserfs sd_mod ahci ata_piix libata
> scsi_mod
> CPU:    0
> EIP:    0060:[<f88642bd>]    Tainted: G   M  VLI
> EFLAGS: 00010282   (2.6.12-22mdksmp)

Can you reproduce with an untainted kernel ??

This is what you also need to report to the above mentioned address...

--
Thomas

