Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTDDLSU (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTDDLST (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:18:19 -0500
Received: from siaag2ac.compuserve.com ([149.174.40.133]:24472 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S263625AbTDDLK5 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 06:10:57 -0500
Date: Fri, 4 Apr 2003 06:18:19 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: How to fix the ptrace flaw without rebooting
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304040622_MC3-1-32FC-81F2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema wrote:


> A better fix in a running system is to simply disable dynamic module
> loading: echo /no/such/file > /proc/sys/kernel/modprobe


 You mean like this?

   # echo 'x'>/proc/sys/kernel/modprobe
   bash: /proc/sys/kernel/modprobe: No such file or directory

:)

--
 Chuck
