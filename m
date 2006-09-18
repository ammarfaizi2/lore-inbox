Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965620AbWIRJr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965620AbWIRJr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 05:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965622AbWIRJr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 05:47:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:63789 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965620AbWIRJrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 05:47:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lWs4C7XLAhhaEW/fiOpSICGJNxQueLVTujtrUxb47lNvmZhOp4hEUAx51R6iRT69porI8hDfkGT13/z/dzDYpRefE/3RNqFz5Xucqj8alg1dJwb6vTbVR9X8YS/sQDJRuyj0e+K4K1CKp54YOSBL6L4gXwUvlAtFc931k1GywdA=
Message-ID: <b6fcc0a0609180247j460811fao651a7883bb4dd668@mail.gmail.com>
Date: Mon, 18 Sep 2006 13:47:23 +0400
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Joe Jin" <lkmaillist@gmail.com>
Subject: Re: kernel panic on T60 by e1000 driver
Cc: e1000-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <215036450609172228l21e8fb2drbdd880f7c1bfcc21@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <215036450609172228l21e8fb2drbdd880f7c1bfcc21@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only authors of proprietary modules you loaded can debug this.
Please, redirect this and all futher oopses to them.

On 9/18/06, Joe Jin <lkmaillist@gmail.com> wrote:
> while I try to transmit a 8k data by send() on my laptap T60,  kernel
> panic occured:

> Modules linked in: rds cisco_ipsec parport_pc lp parport autofs4
> pcmcia opw3945 ieee80211 ie80211_crypt ipt_REJECT xt_tcpudp x_tables
> vfat fat dm_mirror dm_mod ibm-acpi button battery ac yenta_socket
> rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd i2c_i801 i2c_core e1000
> ext3 jbd ahci libata sd_mod scsi_mod
> CPU:    0
> EIP:    0060:[<f8e02261>]       Tainted:        PF      VLI
