Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTLVUKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 15:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTLVUKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 15:10:30 -0500
Received: from main.gmane.org ([80.91.224.249]:51137 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264442AbTLVUK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 15:10:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Per Jessen <per@computer.org>
Subject: Re: make menuconfig loops ??
Date: Mon, 22 Dec 2003 21:06:54 +0100
Message-ID: <bs7isu$6fo$1@sea.gmane.org>
References: <20031221144427.57D00DAA81@mail.local.net> <16358.45353.786574.288849@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

> Per Jessen writes:
>  > Hi,
>  >   
>  > I have a problem when trying to build a kernel. It appears that make
>  > menuconfig starts to loop -
>  > after writing "Preparing scripts: functions, parsing ...done."
>  > This is 2.4.23, jfs114, gcc3.3.2.
> 
> I have seen this when file system with kernel sources was mounted
> noexec. What is in /proc/mounts?
> 

Nikita, 

/proc/mounts:

earth:/etc # cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / jfs rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hda1 /boot jfs rw 0 0
/dev/hda4 /data1 jfs rw 0 0
tmpfs /dev/shm tmpfs rw 0 0


/Per


