Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbRFEMy4>; Tue, 5 Jun 2001 08:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261881AbRFEMyr>; Tue, 5 Jun 2001 08:54:47 -0400
Received: from [217.27.32.7] ([217.27.32.7]:58914 "EHLO leonid.francoudi.com")
	by vger.kernel.org with ESMTP id <S261854AbRFEMye>;
	Tue, 5 Jun 2001 08:54:34 -0400
Date: Tue, 5 Jun 2001 15:47:45 +0300
From: Leonid Mamtchenkov <leonid@francoudi.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.5[-ac8] warnings while compiling
Message-ID: <20010605154744.A13643@francoudi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux leonid.francoudi.com 2.4.3
X-Uptime: 3:44pm  up 7 days,  6:38, 15 users,  load average: 0.24, 1.07, 1.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

While compile kernel 2.4.5 or 2.4.5-ac8 I get lots of warning, which look like
this:
---- kernel.stderr start ----
In file included from /usr/src/linux-2.4.5-ac8/include/linux/raid/md.h:51,
                 from init/main.c:25:
/usr/src/linux-2.4.5-ac8/include/linux/raid/md_k.h: In function `pers_to_level':
/usr/src/linux-2.4.5-ac8/include/linux/raid/md_k.h:41: warning: control reaches end of non-void function
In file included from /usr/src/linux-2.4.5-ac8/include/linux/modversions.h:194,
                 from /usr/src/linux-2.4.5-ac8/include/linux/module.h:21,
                 from fork.c:19:
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:1:33: warning: "__ver_proc_sys_root" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:1:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:3:33: warning: "__ver_proc_symlink" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:3:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:5:33: warning: "__ver_proc_mknod" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:5:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:7:33: warning: "__ver_proc_mkdir" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:7:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:9:33: warning: "__ver_create_proc_entry" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:9:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:11:33: warning: "__ver_remove_proc_entry" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:11:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:13:25: warning: "__ver_proc_root" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:13:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:15:33: warning: "__ver_proc_root_fs" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:15:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:17:25: warning: "__ver_proc_net" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:17:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:19:25: warning: "__ver_proc_bus" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:19:1: warning: this is the location of the previous definition
/usr/src/linux-2.4.5-ac8/include/linux/modules/root.ver:21:33: warning: "__ver_proc_root_driver" redefined
/usr/src/linux-2.4.5-ac8/include/linux/modules/procfs_syms.ver:21:1: warning: this is the location of the previous definition
----- kernel.stderr end -----

Is there a patch available to fix this problem?

-- 
 Best regards,
 Leonid Mamtchenkov
 System Administrator

