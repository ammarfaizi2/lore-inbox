Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbUAaA7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUAaA7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:59:44 -0500
Received: from av1-2-sn1.fre.skanova.net ([81.228.11.108]:26031 "EHLO
	av1-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S264507AbUAaA7n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:59:43 -0500
From: Roger Larsson <roger.larsson@norran.net>
To: linux-kernel@vger.kernel.org, joe619017@yahoo.com,
       "'David Hinds'" <dahinds@users.sourceforge.net>
Subject: Problems with IDE CF - SMP (PREEMPT)
Date: Sat, 31 Jan 2004 02:50:57 +0100
User-Agent: KMail/1.6.50
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401310250.57492.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that since ide-cs has problems with SMP it will have problems with 
PREEMPT as well...

A now old report...
http://pcmcia-cs.sourceforge.net/cgi-bin/HyperNews/get/pcmcia/ide/28.html?nogifs

I have seen problems like this recently (2.4.21) and thought I have read this
somewhere more recent - but can not find it. I will create a bug report.
(Summary: Freezes with SMP, same kernel works with option nosmp)
Remember that drivers that are not SMP safe won't be PREEMPT safe either.

Anyway there are interrupt related PCMCIA problems...
http://sourceforge.net/tracker/?group_id=2405&atid=102405

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
