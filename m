Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbRD0X1v>; Fri, 27 Apr 2001 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRD0X1l>; Fri, 27 Apr 2001 19:27:41 -0400
Received: from cerebus.wirex.com ([216.161.55.93]:16883 "EHLO
	blue.int.wirex.com") by vger.kernel.org with ESMTP
	id <S132520AbRD0X1i>; Fri, 27 Apr 2001 19:27:38 -0400
Date: Fri, 27 Apr 2001 16:28:24 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Latest linux security module patch against 2.4.3
Message-ID: <20010427162824.O6479@wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of the linux security module patch is available at:
	http://lsm.immunix.org/patches/lsm-2001_04_27-2.4.3.patch.gz


Changes in this version include:
	- typo and null pointer dereference fixes from Seth Arnold
	- changed the extra version of the kernel to "lsm" from
	  "immunix"
	- update ptrace hook and fixes
	- added dummy_binprm_compute_creds so no oops on booting.
	- mount and umount changes by Stephen Smalley
	- added inode parameter to inode_ops->alloc_security
	- moved the set and reset label functions to the task group as
	  per Serge Hallyn's comments.
	- can now load capability module
	- removed SubDomain specific values in sysctl.h

thanks,
greg k-h
