Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSJUWXk>; Mon, 21 Oct 2002 18:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbSJUWXk>; Mon, 21 Oct 2002 18:23:40 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:45023 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S261750AbSJUWXi>; Mon, 21 Oct 2002 18:23:38 -0400
Date: Mon, 21 Oct 2002 17:29:34 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: Doug Ledford <dledford@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <andmike@us.ibm.com>,
       <cliffw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-megaraid-devel@Dell.com>
Subject: Re: 2.5.44 compile problem: MegaRAID driver
In-Reply-To: <20021021222500.GK28914@redhat.com>
Message-ID: <Pine.LNX.4.44.0210211726450.11489-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course, I'm personally of the opinion that people need to quite 
> thinking in terms of host order anyway and let things like mount by volume 
> solve this issue anyway.  It's cleaner, it works regardless of the driver, 
> and it puts the burden of finding the right root partition in user space 
> where it's easier to fix up should things change, etc.

EDD lets the OS Installer decide on which unkissed disk it should first
put the OS loader and root partition.  On kissed disks
mount-by-{fs,partitiontable}-label/uuid/whatever is great I agree. It's
the unkissed disks that really mess you up.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


