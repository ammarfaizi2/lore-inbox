Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbUKRGiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUKRGiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbUKRGiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:38:25 -0500
Received: from smtpout3.compass.net.nz ([203.97.97.135]:12519 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S262635AbUKRGhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:37:53 -0500
Date: Thu, 18 Nov 2004 19:39:21 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@linuxcd
Reply-To: haiquy@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: Strange problem with pppoe module
Message-ID: <Pine.LNX.4.53.0411181855250.5442@linuxcd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got strange problem but not sure it is kernel pppoe module or rp-pppoe plugin
+ pppd problem.

Kernel 2.6.7 and 2.6.9 have same problem. Not tested with any other kernel yet.
pppd version 2.4.2

The problem is, 1. when using rp-pppoe plugin (so it will use the kernel pppoe
module) I can not get pop3 mail from MS outlook (running in a window box in the
local LAN). The box can access the pop3 server but the authorization process
failled. The strange thing is, at the about 3 minutes when the connection is up
I can get pop3 mail. It stops working after a while (say 3 or 5 minutes). All
other internet uses is fine. (web browsing, smtp, http, ftp). The problem persists
even if I run adsl-stop, and set /etc/ppp/pppoe.conf not to use rp-pppoe so it
will start pppoe. Run rmmod pppoe and rmmod pppox doesn't solve the problem.
The box need rebooted.

2. Can not access secure site of mail.yahoo.com. The step is, first access
http://mail.yahoo.com/ and click Secure link (to login using https), It is
strange that any other https is fine.

Problem 2 happen right away after the ppp connection is up. At the moment I have
to use pppoe. As I run crux linux in this box, I can not use kernel 2.4 to test
if it happened because crux glibc seems to be compiled with kernel 2.6 header only.

Anything I can help to debug the problem? Please help.

Kind regards,

Steve Kieu
