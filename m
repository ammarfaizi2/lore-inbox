Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264003AbTCXAKo>; Sun, 23 Mar 2003 19:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264012AbTCXAKo>; Sun, 23 Mar 2003 19:10:44 -0500
Received: from pop017pub.verizon.net ([206.46.170.210]:31477 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S264003AbTCXAKn>; Sun, 23 Mar 2003 19:10:43 -0500
Subject: 2.5.65: orinoco unregister_netdevice: usage count
From: nomadduck@hotmail.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048465303.1648.11.camel@bigboy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Mar 2003 19:21:43 -0500
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [68.160.206.163] at Sun, 23 Mar 2003 18:21:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While shutting down the PCMCIA service, I receive the following error:

unregister_netdevice: waiting for eth1 to become free. Usage count = 2

and the shutdown of PCMCIA is stuck at 'modprobe -r orinoco_cs'.

I had the same error in 2.5.64. There seems to be a problem unloading
the orinoco_cs module. Or do I have to upgrade the PCMCIA scripts?

Thanks,

Raf.

