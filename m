Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTEJVBx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 17:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTEJVBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 17:01:53 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:49960 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S264510AbTEJVBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 17:01:38 -0400
From: Jos Hulzink <josh@stack.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: irq balancing: performance disaster
Date: Sun, 11 May 2003 01:18:10 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305110118.10136.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While tackling bug 699, it became clear to me that irq balancing is the cause 
of the performance problems I, and all people using the SMP kernel Mandrake 
9.1 ships, are dealing with. I got the problems with 2.5.69 too. After 
disabling irq balancing, the system is remarkably faster, and much more 
responsive. 

For those interested in the issue, please look at bug 699.

Jos
