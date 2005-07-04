Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVGDFR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVGDFR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 01:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVGDFR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 01:17:59 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:53143 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S261407AbVGDFR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 01:17:57 -0400
Message-ID: <42C8C680.20900@lbsd.net>
Date: Mon, 04 Jul 2005 05:17:52 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050106
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [release] bootutils 0.0.4
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

After looking over initramfs and fiddling for a number of ours I've 
written a small set of utilities (currently only 1) to facilitate an 
alternative to Nash and run_init.

I would appreciate any feedback aswell as comments and/or results of 
anyone's findings.


Introduction:
BootUtils is a collection of utilities to facilitate booting of modern 
Kernel 2.6 based systems. BootUtils is designed for initramfs, although 
volunteers to add support for initrd are welcome. The process of finding 
the root volume either by label or explicit label= on the kernel command 
line, mounting it and 'switchroot'ing is automated. BootUtils can also 
drop to emergency shell if the root volume cannot be mounted. Why not 
even start sshd and allow admin login if the box is in a remote location?

Features:
# Automatic detection of root volume by label or explicit kernel 
commandline option
# Supports ext2, ext3, jfs, reiserfs and xfs
# Emergency shell dropping in the case of a root volume problem
# Distribution independant


More information can be found on the freshmeat release.
http://www.freshmeat.net/projects/bootutils/


Regards
Nigel
