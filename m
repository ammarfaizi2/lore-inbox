Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUHELsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUHELsw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUHELsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:48:52 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:1784 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267648AbUHELss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:48:48 -0400
Subject: Re:  secure computing for 2.6.7
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: flx@msu.ru
Cc: Hans Reiser <reiser@namesys.com>, andrea@cpushare.com,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040803210239.GB7236@alias.nmd.msu.ru>
References: <20040704173903.GE7281@dualathlon.random>
	 <40EC4E96.9090800@namesys.com>
	 <1091536845.7645.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20040803210239.GB7236@alias.nmd.msu.ru>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1091706433.11061.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 07:47:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 17:02, Alexander Lyamin wrote:
> convinience ? speed ?
> 
> 
> RBAC is a Good Thing, but I wonder if it could provide throughout syntax analysis
> for vfs related syscalls. As it is now.
> 
> At least what declared in their docs, fs-wise they are somewhat like this
> 
> Macro Name	Description
> stat_file_perms	Permissions to call stat or access on a file.
> x_file_perms	Permissions to execute a file.
> r_file_perms	Permissions to read a file.
> rx_file_perms	Permissions to read and execute a file.
> rw_file_perms	Permissions to read and write a file.
> ra_file_perms	Permissions to read and append to a file.
> link_file_perms	Permissions to link, unlink, or rename a file.
> create_file_perms	Permissions to create, access, and delete a file.
> r_dir_perms	Permissions to read and search a directory.
> rw_dir_perms	Permissions to read and modify a directory.
> ra_dir_perms	Permissions to read and add entries to a directory.
> create_dir_perms	Permissions to create, access, and delete a directory.
> mount_fs_perms	Permissions to mount and unmount a filesystem.

I'm not sure I understand what you are trying to say.  What you list
above are common sets of permissions defined as macros for convenience,
but you still have the freedom to specify individual permissions.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

