Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWJFSK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWJFSK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWJFSK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:10:28 -0400
Received: from main.gmane.org ([80.91.229.2]:23193 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932446AbWJFSK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:10:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: safe_smp_processor_id i386 and x86_64
Date: Fri, 06 Oct 2006 22:02:17 +0530
Message-ID: <eg60ej$qqe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.198.246
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the git log and the below changes confused me.

dc2bc768a009b9ad8711894c544dc6b0d8c0ce57

commit dc2bc768a009b9ad8711894c544dc6b0d8c0ce57
Author: Fernando Vazquez <fernando@intellilink.co.jp>
Date:   Sat Sep 30 23:29:07 2006 -0700

    [PATCH] stack overflow safe kdump: safe_smp_processor_id()

..............

   This patch set does the following:

    * Add safe_smp_processor_id function to i386 architecture (this function was
      inspired by the x86_64 function of the same name).

151f8cc1169f9052095b2be36183ab132d75c6c2

commit 151f8cc1169f9052095b2be36183ab132d75c6c2
Author: Andi Kleen <ak@suse.de>
Date:   Tue Sep 26 10:52:37 2006 +0200

    [PATCH] Remove safe_smp_processor_id()




-aneesh

