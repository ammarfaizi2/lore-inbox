Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVBWDzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVBWDzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 22:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVBWDzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 22:55:25 -0500
Received: from ws9.cdotb.ernet.in ([202.41.72.121]:30727 "EHLO
	ws9.cdotb.ernet.in") by vger.kernel.org with ESMTP id S261415AbVBWDzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 22:55:22 -0500
Date: Wed, 23 Feb 2005 09:37:37 +0500 (GMT+0500)
From: Vijayalakshmi Hadimani <vijaya_h@cdotb.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: msgsnd in module
Message-ID: <Pine.OSF.4.21.0502230934500.2967-100000@ws9.cdotb.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
   I am inserting a module(device driver) using insmod. 
I want to send a message from this module to an user process.
For this I used msgsnd with buffer in the call as a local 
variable.  I am getting an error "EFAULT" for this call. 
However this did not happen when I made the driver code as a
part of kernel and not as a module.  Any idea about what could
be the problem and how to solve it?

TIA

Regards,
Vijayalakshmi

