Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbULFQqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbULFQqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbULFQqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:46:07 -0500
Received: from main.gmane.org ([80.91.229.2]:7564 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261561AbULFQp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:45:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Date: Mon, 06 Dec 2004 11:45:27 -0500
Message-ID: <87sm6jpe8o.fsf@coraid.com>
References: <87acsrqval.fsf@coraid.com>
	<Pine.LNX.4.58.0412061027510.2173@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-34-230-221.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:KAV+JO2vrQ2Bf6BAXthf5vpMYk8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Heath <doogie@debian.org> writes:

> On Mon, 6 Dec 2004, Ed L Cashin wrote:
>
>> The included patch allows the Linux kernel to use the ATA over
>> Ethernet (AoE) network protocol to communicate with any block device
>> that handles the AoE protocol.  The Coraid EtherDrive (R) Storage
>> Blade is the first hardware using AoE.
>>
>> AoE devices on the LAN are accessable as block devices and can be used
>> with filesystems, Software RAID, LVM, etc.
>>
>> Like IP, AoE is an ethernet-level network protocol, registered with
>> the IEEE.  Unlike IP, AoE is not routable.
>>
>> This patch is released under the terms of the GPL.
>>
>> (We also have an AoE driver for the 2.4 kernel that we plan to release
>> soon.)
>
> Is there a free server for this?

Are you asking whether anybody has written software that allows a
network host to export block storage using AoE?  Not yet, as far as I
know.

-- 
  Ed L Cashin <ecashin@coraid.com>

