Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUE0Exx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUE0Exx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 00:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUE0Exw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 00:53:52 -0400
Received: from [61.95.205.193] ([61.95.205.193]:39296 "HELO asthatech.com")
	by vger.kernel.org with SMTP id S261347AbUE0Exr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 00:53:47 -0400
Date: Thu, 27 May 2004 10:15:03 +0530
From: Sreekandh Iyer <sree@asthatech.com>
To: linux-kernel@vger.kernel.org
Subject: Socket Close Problem
Message-Id: <20040527101503.5a98c292.sree@asthatech.com>
Organization: Astha Technologies
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We have a simple TCP client and server setup. We want the tcp client
sockets to close immediately once the close method is called as the no
of open sockets is increasing rapidly as many are still in the TIME_WAIT
state.We tried the SO_LINGER option to eliminate the TIME_WAIT state but
it doesn't seem to be effective on our Linux - 2.4.18-14.
We need a solution to the "close" problem desperately. We would
appreciate it if you could kindly help us find a solution.

Regards and TIA,
sree

 
 

-- 
Om. May all be happy; may all be healthy ;
may all see good in all. May none experience misery. 

Om. peace! peace! peace!
