Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUAGTGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUAGTGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:06:09 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:21675 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S265573AbUAGTGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:06:06 -0500
X-Sender-Authentication: net64
Date: Wed, 7 Jan 2004 20:05:56 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org
Subject: Problem with 2.4.24 e1000 and keepalived
Message-Id: <20040107200556.0d553c40.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am looking for confirmation for the following problem.
Setup is a simple pair of routers with 2 nics each, all e1000. If you start a
vrrp setup with keepalived and interface state is down during keepalived
startup, then the failover does not work. If the nics are UP during startup
everything works well. Now the kernel part of the story: the exact same setup
works with tulip cards.
Is there a difference regarding UP/DOWN state handling/events in e1000 and
tulip. e100 and eepro100 show the same problem btw.

Any hints are welcome

Regards,
Stephan
