Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272357AbRIKSjM>; Tue, 11 Sep 2001 14:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272358AbRIKSjD>; Tue, 11 Sep 2001 14:39:03 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:48136 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S272357AbRIKSiv>; Tue, 11 Sep 2001 14:38:51 -0400
Message-ID: <276737EB1EC5D311AB950090273BEFDD043BC5A2@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'nfs-request@lists.sourceforge.net'" 
	<nfs-request@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Questions on NFS client inode management.
Date: Tue, 11 Sep 2001 14:30:18 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question on inode management for NFS client.
It seems that the inodes created on a NFS client for 
a mounted nfs file system stays around until the file 
being removed. Is there any limits on how many inodes
are allowed in memory for NFS? What kind of behavior
we expect if a malicious/careless application just 
keeps creating new files and flood the kernel memory 
with inodes created?

Thanks,

Xiangping 
