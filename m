Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTEIDgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 23:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTEIDgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 23:36:25 -0400
Received: from clavin.cs.tamu.edu ([128.194.130.106]:27863 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id S262283AbTEIDgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 23:36:24 -0400
Date: Thu, 8 May 2003 22:49:01 -0500 (CDT)
From: Xinwen Fu <xinwenfu@cs.tamu.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linksys workgroup switch works like a hub
Message-ID: <Pine.GSO.4.44.0305082240450.16315-100000@unix.cs.tamu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is really weird!

Host_10.1--->10.254_router_1.254--->Linksys 5-port workgroup switch-->Host1.1
                                       |               |
                                       |               |
                                       v               v
                                    Host_1.10        Host_1.5

Host_10.1 sends 1000 packets/s (pps) to Host_1.10. Host_1.10 receives the
packets. But Host_1.5 receives the packets too, while Host_1.1 does not
(by tcpdump -i any).

	What is the possible reason?

	Thanks!
Xinwen Fu


