Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVCTE7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVCTE7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 23:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVCTE7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 23:59:14 -0500
Received: from jade.aracnet.com ([216.99.193.136]:59065 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S262025AbVCTE7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 23:59:02 -0500
Date: Sat, 19 Mar 2005 20:58:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ppc64 build broke between 2.6.11-bk6 and 2.6.11-bk7
Message-ID: <515230000.1111294739@[10.10.2.4]>
In-Reply-To: <20050317224409.41f0f5c5.akpm@osdl.org>
References: <445800000.1111127533@[10.10.2.4]> <20050317224409.41f0f5c5.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Thursday, March 17, 2005 22:44:09 -0800):

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> drivers/built-in.o(.text+0x182bc): In function `.matroxfb_probe':
>> : undefined reference to `.mac_vmode_to_var'
>> make: *** [.tmp_vmlinux1] Error 1
>> 
>> Anyone know what that is?
>> 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/broken-out/fbdev-kconfig-fix-for-macmodes-and-ppc.patch
> 
> should fix it.

Great - tested, that fixed it up for me.

Thanks,

M.

