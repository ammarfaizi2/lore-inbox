Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWJLXY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWJLXY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWJLXY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:24:58 -0400
Received: from web83115.mail.mud.yahoo.com ([216.252.101.44]:12919 "HELO
	web83115.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751317AbWJLXY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:24:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CLK8sILmHYk0FRvzrT6MRZ6Hv87/D8IRVMI4YIZ5dYKSQ2YZVJsNNPYwyD0i+2CZMpnIybXeiTu0e2vSAejVbeGdYFWBLsnnj4bSbPjmVH8YU7CxgLHnPAb1UZyBRkcoY5FJYARS/JE4lRfLcpOo/3L4JW/Y/UL4lCJcTnGcxkQ=  ;
Message-ID: <20061012232456.69718.qmail@web83115.mail.mud.yahoo.com>
Date: Thu, 12 Oct 2006 16:24:56 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: RE: Machine reboot
To: xhejtman@mail.muni.cz, linux-kernel@vger.kernel.org, magnus.damm@gmail.com,
       pavel@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lukas 
>Hejtmanek
>Sent: Thursday, October 05, 2006 3:53 AM
>To: linux-kernel@vger.kernel.org
>Subject: Machine reboot
>
>Hello,
>
>I'm facing troubles with machine restart. While sysrq-b 
>restarts machine, reboot
>command does not. Using printk I found that kernel does not 
>hang and issues
>reset properly but BIOS does not initiate boot sequence. Is 
>there something
>I could do?

  I have similar issue on Intel DG965WH board. Did you try to shutdown network interface and
'rmmod e1000' right before reboot ? In my case machine reboots fine after that.

Aleks.
