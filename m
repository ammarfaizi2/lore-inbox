Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTLKCUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 21:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLKCUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 21:20:32 -0500
Received: from fep03-svc.mail.telepac.pt ([194.65.5.202]:47575 "EHLO
	fep03-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S264301AbTLKCU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 21:20:27 -0500
Subject: pppoe causes oops on 2.6.0-test10
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Graycell
Message-Id: <1071109123.1672.12.camel@taz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 02:18:43 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm using pppoe to connect to the internet using an Alcatel Speedtouch
USB ADSL modem. Recently I started getting this oops when connecting, I
think after upgrading br2684ctl.
After this happens I can reboot using Magic SysRq bu nothing else.
I wrote this down on a paper, if this info is not enough I can reproduce
it and write down the full oops.
EIP in pfifo_fast_dequeue

Backtrace
---------
qdisc_restart
net_tx_action
__pollwait
do_softirq
packet_poll
do_select
__pollwait
sys_select
schedule
syscall_call

Thanks
--
Nuno

