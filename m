Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318232AbSICQDN>; Tue, 3 Sep 2002 12:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318249AbSICQDN>; Tue, 3 Sep 2002 12:03:13 -0400
Received: from mailgate2.Cadence.COM ([158.140.2.31]:57783 "EHLO
	mailgate2.Cadence.COM") by vger.kernel.org with ESMTP
	id <S318232AbSICQDM>; Tue, 3 Sep 2002 12:03:12 -0400
Message-ID: <3D74DB89.9090605@cadence.com>
Date: Tue, 03 Sep 2002 08:55:53 -0700
From: Mitch Sako <msako@cadence.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Kernel Automounter
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing some strangeness here.  When running 2.4.18 NFS mounting 
FROM Solaris 2.7 using '/net -hosts' to get the Solaris /net/<hostname> 
mounting, it seems that it requires CONFIG_NFS_V3 to do the 
/net/<hostname> mount, even if the mount takes place using NFSV2.  NFSV2 
/net/<hostname> mounts from a Linux server works fine.  Manually 
mounting from Solaris 2.7 using the 'mount' command also works fine with 
NFSV2.  It only seems that the amd '/net -hosts' is broken because 
Solaris is only talking TCP/IP during the initial mount request.

Is this a kernel or amd issue?

Mitch


