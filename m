Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268361AbSIRVAW>; Wed, 18 Sep 2002 17:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268369AbSIRVAW>; Wed, 18 Sep 2002 17:00:22 -0400
Received: from host.greatconnect.com ([209.239.40.135]:60176 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S268361AbSIRVAV>; Wed, 18 Sep 2002 17:00:21 -0400
Message-ID: <3D88EB5D.3030807@rackable.com>
Date: Wed, 18 Sep 2002 14:08:45 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre7-ac1
References: <200209181703.g8IH3dk10674@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slight  issue with jfs:
[root@grendel linux-2.4.20-pre7]# /sbin/depmod -ae -F System.map  
2.4.20-pre7-ac1
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20-pre7-ac1/kernel/fs/jfs/jfs.o
depmod:         cond_resched
[root@grendel linux-2.4.20-pre7]# rpm -q modutils
modutils-2.4.18-2



