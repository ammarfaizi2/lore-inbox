Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291177AbSBGSRt>; Thu, 7 Feb 2002 13:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291174AbSBGSRj>; Thu, 7 Feb 2002 13:17:39 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:12969 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291173AbSBGSRW>; Thu, 7 Feb 2002 13:17:22 -0500
Message-ID: <3C62C4AB.3040109@nyc.rr.com>
Date: Thu, 07 Feb 2002 13:17:15 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI Hotplug and Linux 2.5.4-pre2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't find the definition of pcihpfs_fs_type used in 
pci_hotplug_core.c in register_filesystem(), unregister_filesystem(),
and kern_mount().  This is causing a compilation error.

PS - I don't use this in my kernel, so I can disable it from my
config without penalty.  But seeing as I don't see any posts
about this on LKML, should I try to build kernels with everything
enabled in the future (just to get these small errors stomped out
quickly)?

