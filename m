Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293378AbSCFJFL>; Wed, 6 Mar 2002 04:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293379AbSCFJFC>; Wed, 6 Mar 2002 04:05:02 -0500
Received: from scentra.dntcj.ro ([193.226.99.17]:65162 "EHLO scentra.dntcj.ro")
	by vger.kernel.org with ESMTP id <S293378AbSCFJEt>;
	Wed, 6 Mar 2002 04:04:49 -0500
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: scentra.dntcj.ro
Message-ID: <3C85DAD4.4060504@dntcj.ro>
Date: Wed, 06 Mar 2002 11:01:08 +0200
From: Dimtiriu Vlad <dim@dntcj.ro>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Same problem with 3c905B nic
In-Reply-To: <200203060842.g268gfq21995@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.3.0(snapshot 20010925) (scentra.dntcj.ro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    The same problem here:

*    3Com Corporation 3cSOHO100-TX Hurricane

*    /etc/modules.conf
     options 3c59x debug=3 rx_copybreak=300
   
Mar  6 11:02:54 lambda kernel: dev->watchdog_timeo=500
Mar  6 11:02:54 lambda kernel: eth1: MII transceiver has status 786d.
Mar  6 11:02:54 lambda kernel: eth1: Media selection timer finished,
Autonegotiate.
Mar  6 11:02:54 lambda kernel: eth2: Media selection timer
tick happened, Autonegotiate.
Mar  6 11:02:54 lambda kernel: dev->watchdog_timeo=500
Mar  6 11:02:54 lambda kernel: eth2: MII transceiver has status 786d.
Mar  6 11:02:54 lambda kernel: eth2: Media selection timer finished,
Autonegotiate.
Mar  6 11:03:10 lambda kernel: eth2: vortex_error(), status=0xe481


Those twho NICs are connected into a CenterCom
3016SL 10MB/s HUB.

