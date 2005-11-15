Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVKOGDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVKOGDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 01:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVKOGDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 01:03:52 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:57054 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751346AbVKOGDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 01:03:51 -0500
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B13B7CA@mail.esn.co.in>
References: <3AEC1E10243A314391FE9C01CD65429B13B7CA@mail.esn.co.in>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A26C7F2-005D-470B-ACFC-5F4E91AE9503@comcast.net>
Cc: <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: FC4 Device permission Issues
Date: Tue, 15 Nov 2005 01:03:35 -0500
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 15, 2005, at 12:42 AM, Mukund JB. wrote:

> type=PATH msg=audit(1131719847.291:372708): item=0 name="/dev/tfa3"
> inode=9633 dev=00:0d mode=060666 ouid=0 ogid=0 rdev=fc:18
> type=AVC msg=audit(1131719847.291:372708): avc: denied { read } for
> pid=2849 comm="mkfs.vfat" name=tfa3 dev=tmpfs ino=9633
> scontext=root:system_r:fsadm_t tcontext=system_u:object_r:device_t
> tclass=blk_file

Something to do with SELINUX. Either try turning SELINUX off or  
change the policy in use to permissive. (http://fedora.redhat.com/ 
docs/selinux-faq-fc3/index.html)

BTW Distro specific questions are better handled on the Distro's  
mailing list. Fedora has one.

Parag
