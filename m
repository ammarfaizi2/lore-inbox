Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265947AbUF2X60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUF2X60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUF2X60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:58:26 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:49907 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265947AbUF2X6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:58:24 -0400
Subject: Re: [PATCH][PPC64] lparcfg seq_file update
From: Dave Hansen <haveblue@us.ibm.com>
To: will schmidt <will_schmidt@vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <40E1F6FC.3030405@vnet.ibm.com>
References: <40E1F6FC.3030405@vnet.ibm.com>
Content-Type: text/plain
Message-Id: <1088553490.26704.43.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 16:58:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 16:10, will schmidt wrote:
> Hi All,
>     This patch includes updates and cleanup for the PPC64 proc/lparcfg 
> interface.

I think your mailer whitespace-munged the patch.  

Also, why do you need this information:

+       seq_printf(m, "partition_active_processors=%d\n",
+                       (int) lparcfg_count_active_processors());

Doesn't that duplicate information already exported in /proc/cpuinfo and
/sys/devices/system/cpu?

-- Dave

