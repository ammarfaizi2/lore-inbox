Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUHGXPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUHGXPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUHGXPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:15:33 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:41184 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264585AbUHGXPX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:15:23 -0400
Message-ID: <411562FD.5040500@blue-labs.org>
Date: Sat, 07 Aug 2004 19:17:17 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: warning: comparison is always false due to limited range of data
 type
Content-Type: multipart/mixed;
 boundary="------------010203020804090401060907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203020804090401060907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

2.6.8-rc3

  CC      fs/smbfs/inode.o
fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:563: warning: comparison is always false due to limited 
range of data type
fs/smbfs/inode.c:564: warning: comparison is always false due to limited 
range of data type

    559         mnt->ttl = SMB_TTL_DEFAULT;
    560         if (ver == SMB_MOUNT_OLDVERSION) {
    561                 mnt->version = oldmnt->version;
    562
    563                 SET_UID(mnt->uid, oldmnt->uid);
    564                 SET_GID(mnt->gid, oldmnt->gid);
    565
    566                 mnt->file_mode = (oldmnt->file_mode & S_IRWXUGO) 
| S_IFREG;
    567                 mnt->dir_mode = (oldmnt->dir_mode & S_IRWXUGO) | 
S_IFDIR;
    568
    569                 mnt->flags = (oldmnt->file_mode >> 9);
    570         } else {
    571                 if (parse_options(mnt, raw_data))
    572                         goto out_bad_option;
    573         }


--------------010203020804090401060907
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------010203020804090401060907--
