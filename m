Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269000AbRHCMY1>; Fri, 3 Aug 2001 08:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269021AbRHCMYR>; Fri, 3 Aug 2001 08:24:17 -0400
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:47052 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S269000AbRHCMYB>; Fri, 3 Aug 2001 08:24:01 -0400
Date: Fri, 3 Aug 2001 08:24:08 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: ext3-users <ext3-users@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: ac4 ext3 recovery failure
Message-ID: <20010803082408.A800@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: ext3-users <ext3-users@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rebooting to try 2.4.7-ac4, I had Xfree86 crash on exit and hang the
machine (it does that once a month or so; this notebook gets booted
quite often).  After fscking the root and another ext2 partition, the
system got to the big ext3 partition and just went dead.  No message,
no disk activity, no keyboard response.  I powered down and rebooted
2.4.7-ac3 patched with ext3-2.4-0.9.5-247ac3, and that came up ok and
recovered the journalled partition.

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
