Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbTDNSyk (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTDNSyj (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:54:39 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:50181 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S263832AbTDNSyc (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:54:32 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <36696BAFD8467644ABA0050BE35890591257F9@ausx2kmpc106.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: linux-kernel@vger.kernel.org
Subject: devlabel: added ownership, permissioning consistency
Date: Mon, 14 Apr 2003 14:05:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1285D91714940-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Devlabel 0.30.08 is now available at http://www.lerhaupt.com/devlabel/

It includes the --uid, --gid, --perms parameters which are usable when
adding a symlink to a disk/partition.

This ensures that the correct ownership and permissions are applied to the
underlying disk name in the event that your disk names shuffle.  So, even if
you choose not to use devlabel symlinks in /etc/fstab to ensure that you are
always mounting your right disks, you may now consider at least using
devlabel just to make sure the right permissions and ownerships are applied
to your disks in the event of a device renaming event.  Of course, if all
your partitions are just root,disk 0660 this won't make much difference.
But, if they aren't, it closes that security hole.

Gary Lerhaupt
Linux Development
Dell Computer Corporation

