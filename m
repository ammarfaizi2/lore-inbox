Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270230AbTHCAaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 20:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270455AbTHCAaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 20:30:18 -0400
Received: from codepoet.org ([166.70.99.138]:50395 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270230AbTHCAaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 20:30:16 -0400
Date: Sat, 2 Aug 2003 18:30:20 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Willem Bison <wbison@xs4all.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem installing Promise SATA150 TX2plus driver
Message-ID: <20030803003019.GA8019@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Willem Bison <wbison@xs4all.nl>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 02 2003 at 16:47:03 EST, Willem Bison wrote:
> When trying to 'insmod' the Promise SATA150 TX2plus driver
> mentioned in this message:
> http://www.van-dijk.net/linuxkernel/200330/1084.html.gz
> I get these errors:
> /lib/modules/2.4.20-8smp/kernel/drivers/scsi/pdc-ultra.o: unresolved symbol
> scsi_unregister_module
> and ...scsi_register, ...scsi_register_module, ...scsi_unregister 

I bet you have CONFIG_SCSI disabled...  You really want
to have at a minimum CONFIG_SCSI and CONFIG_BLK_DEV_SD
enabled, either as modules or built into the kernel,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
