Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUDNX3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUDNX3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:29:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:26802 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262071AbUDNX2s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:28:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: proc_pid_stat() question
Date: Wed, 14 Apr 2004 16:18:27 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200404141618.27608.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It may be too dumb question ..

I was wondering how does proc_pid_stat() make sure the task its looking
at doesn't exit while its looking at task->tty etc.. ? 

I was looking at OOPS, where proc_pid_stat() has garbage for task->tty,
so "ps" panics.

Thanks,
Badari
