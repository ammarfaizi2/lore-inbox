Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSKRO6J>; Mon, 18 Nov 2002 09:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSKRO6J>; Mon, 18 Nov 2002 09:58:09 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:10450 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S262528AbSKRO6I>; Mon, 18 Nov 2002 09:58:08 -0500
Message-ID: <3DD90197.4DDEEE61@wipro.com>
Date: Mon, 18 Nov 2002 20:34:55 +0530
From: Rashmi Agrawal <rashmi.agrawal@wipro.com>
Reply-To: rashmi.agrawal@wipro.com
Organization: wipro tech
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom16Nov2002 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Failover in NFS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2002 15:04:57.0194 (UTC) FILETIME=[DBA48CA0:01C28F13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I might be very wrong but I am trying to do following

1. I have a 4 node cluster and nfsv3 in all the nodes of cluster with
server running in one
of the 2 nodesconnected to shared storage and 2 other nodes are acting
as clients.
2. If nfs server node crashes, I need to failover to another node
wherein I need to have access
to the lock state of the previous server and I need to tell the clients
that the IP address of the
nfs server node has changed. IS IT POSSIBLE or what can be done to
implement it?

Another scenario is..
1. When one of the client crashes, it has to failover to another client,
in that case if client
crashed with some locks held how the newly come up client going to grab
the lock again
when it is not released? Again the server might already be taking care
of it but I am not
sure about it.

I hope I can use NFS for this kind of set up and if not what will it
take to have this kind of set
up usinf NFS?

Regards
Rashmi


