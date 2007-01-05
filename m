Return-Path: <linux-kernel-owner+w=401wt.eu-S1030299AbXAECmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbXAECmO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 21:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbXAECmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 21:42:13 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:54850 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1030299AbXAECmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 21:42:12 -0500
Message-ID: <367964923.02447@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 5 Jan 2007 10:42:26 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
Message-ID: <20070105024226.GA6076@mail.ustc.edu.cn>
Mail-Followup-To: Neil Brown <neilb@suse.de>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

NFS mounting succeeded, but the kernel gives a warning.
I'm running 2.6.20-rc2-mm1.

# mount -o vers=3 localhost:/suse /mnt
[  689.651606] svc: unknown version (3)
# mount | grep suse
localhost:/suse on /mnt type nfs (rw,nfsvers=3,addr=127.0.0.1)

Any clues about it?

Short .config:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.20-rc2-mm1
# Thu Jan  4 15:55:02 2007
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y

......

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=m

......

Thanks,
Wu
