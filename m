Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTKVP1x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 10:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTKVP1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 10:27:53 -0500
Received: from iisc.ernet.in ([144.16.64.3]:28309 "EHLO iisc.ernet.in")
	by vger.kernel.org with ESMTP id S262052AbTKVP1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 10:27:51 -0500
From: anand@eis.iisc.ernet.in (SVR Anand)
Message-Id: <200311221527.UAA29684@eis.iisc.ernet.in>
Subject: 2.6.0-test9 : bridge freezes
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Nov 2003 20:57:44 +0530 (GMT+05:30)
Cc: linux-net@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am one of the system administrators who manage a campus network of 5000 users
that is connected to Internet. We have placed a Linux bridge to isolate the 
Internet from the campus. To nullify network flooding effect, we have used 
iptables. The kernel is 2.6.0-test9, the ethernet cards that are used are 
RTL8139.

The problem is : After 3 to 4 hours of functioning, the bridge stops working 
and the machine becomes unusable where it doesn't respond to keyboard, and 
there is no video display. In simple terms it freezes. Before going in for 
2.6.0-test9 I have tried 2.4.20 with bridge patches for iptables support. It
worked reliably except that I cannot even login from the console because 
I don't get the shell prompt after a while. 

Presently I have gone back to 2.4.20 for the sake of robustness. Can someone
let me know what I can do to use 2.6.x kernel with a good amount of confidence
so that I can keep the campus users happy ? I am making guess work as
to whether the problem is with the network drivers, or some power management 
issues, and so on.

Any inputs from you will be really useful. I am eager to try out any amount
of debugging, the thing is I don't know what to look for.


Anand
