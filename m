Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUDSS1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 14:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUDSS1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 14:27:18 -0400
Received: from sankara1.bol.com.br ([200.221.24.109]:15829 "EHLO
	sankara1.bol.com.br") by vger.kernel.org with ESMTP id S261685AbUDSS1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 14:27:15 -0400
Subject: task switching at Page Faults
From: Fabiano Ramos <fabramos@bol.com.br>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082399579.1146.15.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Apr 2004 15:32:59 -0300
Content-Transfer-Encoding: 7bit
X-Sender-IP: 200.165.173.234
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

	I am in doubt about the linux kernel behaviour is this situation:
supose a have the process A, with the highest realtime
priority and SCHED_FIFO policy. The process then issues a syscall,
say read():

	1) Can I be sure that there will be no process switch during the
syscall processing, even if the system call causes a page fault?

	2) What if the process was a non-realtime processes (ordinary
one, SCHED_OTHER)?


Thanks a lot.
Fabiano

