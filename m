Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWFXTin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWFXTin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWFXTin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 15:38:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:15627 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751064AbWFXTim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 15:38:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Za8XSI8Cfhvlm1K15+TOQwZiSDOD8mXmpYoUUhbCZxePh8U5VFxrNCkUjm0G9wXCzqMYcEEMUm60dJKpRlmp5LdfX18Vt4IvE6ErN2IfJfiGc+LjMSYtBgqxH+DY93b8recqM0+7vZUUxU0ardUoNCwG+zMsQ8FF0wzzIvSUOvk=
Date: Sat, 24 Jun 2006 23:39:09 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] ioctl-mess.txt: XFS + typos
Message-ID: <20060624193909.GA30083@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nusigned

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/ioctl-mess.txt |  162 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 2 deletions(-)

--- a/Documentation/ioctl-mess.txt
+++ b/Documentation/ioctl-mess.txt
@@ -1735,7 +1735,7 @@ I: struct hci_dev_req
 O: -
 
 N: HCISETRAW
-I: (nusigned long) arg
+I: (unsigned long) arg
 O: -
 
 N: HCISETSCAN
@@ -1747,7 +1747,7 @@ I: struct hci_dev_req
 O: -
 
 N: HCISETSECMGR
-I: (nusigned long) arg
+I: (unsigned long) arg
 O: -
 
 N: HCIUARTGETPROTO
@@ -4769,6 +4769,164 @@ O: -
 
 WRITE_RAID_INFO
 
+N: XFS_IOC_ALLOCSP
+I: xfs_flock64_t
+O: -
+
+N: XFS_IOC_ALLOCSP64
+I: xfs_flock64_t
+O: -
+
+N: XFS_IOC_ATTRLIST_BY_HANDLE
+I: xfs_fsop_attrlist_handlereq_t
+O: xfs_fsop_attrlist_handlereq_t::buflen
+
+XFS_IOC_ATTRMULTI_BY_HANDLE
+
+N: XFS_IOC_DIOINFO
+I: -
+O: struct dioattr
+
+N: XFS_IOC_ERROR_CLEARALL
+I: -
+O: -
+
+N: XFS_IOC_ERROR_INJECTION
+I: xfs_error_injection_t
+O: -
+
+N: XFS_IOC_FD_TO_HANDLE
+I: xfs_fsop_handlereq_t
+O: xfs_fsid_t + __s32
+
+N: XFS_IOC_FREESP
+I: xfs_flock64_t
+O: -
+
+N: XFS_IOC_FREESP64
+I: xfs_flock64_t
+O: -
+
+N: XFS_IOC_FREEZE
+I: -
+O: -
+
+N: XFS_IOC_FSBULKSTAT
+I: xfs_fsop_bulkreq_t + __s64
+O: [xfs_ino_t + int]
+
+N: XFS_IOC_FSBULKSTAT_SINGLE
+I: xfs_fsop_bulkreq_t + __s64
+O: [xfs_ino_t + int]
+
+N: XFS_IOC_FSCOUNTS
+I: -
+O: xfs_fsop_counts_t
+
+N: XFS_IOC_FSGEOMETRY
+I: -
+O: xfs_fsop_geom_t
+
+N: XFS_IOC_FSGEOMETRY_V1
+I: -
+O: xfs_fsop_geom_v1_t
+
+N: XFS_IOC_FSGETXATTR
+I: -
+O: struct fsxattr
+
+N: XFS_IOC_FSGETXATTRA
+I: -
+O: struct fsxattr
+
+
+N: XFS_IOC_FSGROWFSDATA
+I: xfs_growfs_data_t
+O: -
+
+N: XFS_IOC_FSGROWFSLOG
+I: xfs_growfs_log_t
+O: -
+
+N: XFS_IOC_FSGROWFSRT
+I: xfs_growfs_rt_t
+O: -
+
+N: XFS_IOC_FSINUMBERS
+I: xfs_fsop_bulkreq_t + __s64
+O: [xfs_ino_t + int]
+
+N: XFS_IOC_FSSETDM
+I: struct fsdmidata
+O: -
+
+N: XFS_IOC_FSSETDM_BY_HANDLE
+I: xfs_fsop_setdm_handlereq_t + struct fsdmidata
+O: -
+
+N: XFS_IOC_FSSETXATTR
+I: struct fsxattr
+O: -
+
+N: XFS_IOC_GETBMAP
+I: struct getbmap
+O: struct getbmap
+
+N: XFS_IOC_GETBMAPA
+I: struct getbmap
+O: struct getbmap
+
+N: XFS_IOC_GETBMAPX
+I: struct getbmapx
+O: struct getbmapx
+
+N: XFS_IOC_GET_RESBLKS
+I: -
+O: xfs_fsop_resblks_t
+
+N: XFS_IOC_GOINGDOWN
+I: __uint32_t
+O: -
+
+N: XFS_IOC_OPEN_BY_HANDLE
+I: xfs_fsop_handlereq_t
+O: -
+
+XFS_IOC_PATH_TO_FSHANDLE
+XFS_IOC_PATH_TO_HANDLE
+
+N: XFS_IOC_READLINK_BY_HANDLE
+I: xfs_fsop_handlereq_t + __u32
+O: -
+
+N: XFS_IOC_RESVSP
+I: xfs_flock64_t
+O: -
+
+N: XFS_IOC_RESVSP64
+I: xfs_flock64_t
+O: -
+
+N: XFS_IOC_SET_RESBLKS
+I: xfs_fsop_resblks_t
+O: xfs_fsop_resblks_t
+
+N: XFS_IOC_SWAPEXT
+I: xfs_swapext_t
+O: -
+
+N:XFS_IOC_THAW
+I: -
+O: -
+
+N: XFS_IOC_UNRESVSP
+I: xfs_flock64_t
+O: -
+
+N: XFS_IOC_UNRESVSP64
+I: xfs_flock64_t
+O: -
+
 N: Z90QUIESCE
 I: -
 O: -

