Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270444AbTGWQrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbTGWQrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:47:17 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:52335 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S270444AbTGWQrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:47:14 -0400
Subject: Re: Feature proposal (scheduling related)
From: Disconnect <lkml@sigkill.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030723151321.GC29384@wind.cocodriloo.com>
References: <3F1E6A25.5030308@gmx.net>
	 <200307231417.h6NEHoqj010244@turing-police.cc.vt.edu>
	 <1058970206.5520.71.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.53.0307231050150.13607@chaos>
	 <20030723151321.GC29384@wind.cocodriloo.com>
Content-Type: text/plain
Message-Id: <1058979335.1192.78.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 23 Jul 2003 12:55:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alternately, openbsd can do a similar thing with great results (although
I haven't tried it over serial/pppd.)  And it works reasonably well even
when done on only one end.

http://www.benzedrine.cx/ackpri.html

On Wed, 2003-07-23 at 11:13, Antonio Vargas wrote:

> You need QoS at the router level to resolve this. Since you are
> running your own routers to connect your ethernet segments, QoS
> should be done at both ends of the connection. If it's available
> on your distro, try wondershaper, it's a nice script which you tell
> your upstream and downstream rates and then it adjusts QoS parameters
> to provide great response. The most important thing is that it prioritises
> ACK packets above everything else. This helps a lot when there is heavy
> traffic (FTP for example) in both directions at the same time.

-- 
Disconnect <lkml@sigkill.net>

