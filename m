Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbVIAVuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVIAVuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIAVuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:50:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030423AbVIAVud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:50:33 -0400
Date: Thu, 1 Sep 2005 14:52:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: lkml@dervishd.net, linux-kernel@vger.kernel.org
Subject: Re: USB Storage speed regression since 2.6.12
Message-Id: <20050901145248.2356f03f.akpm@osdl.org>
In-Reply-To: <43176095.1000805@tmr.com>
References: <20050901113614.GA63@DervishD>
	<43176095.1000805@tmr.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
>
> I see a worse problem, I load the driver, mount the filesystems on the 
> USB 160GB disk, and the disk just "goes away." I see the devices in 
> /proc/scsi/scsi but I can't access the devices any more. Definitely time 
> for a fallback to a more stable kernel!

Please us get 2.6.13 fixed first.  Can you generate the dmesg output for
good and bad kernels, diff them and see if there's anything useful there?

What does "can't access" mean?  -EIO?
