Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWE3G0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWE3G0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWE3G0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:26:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:51949 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932162AbWE3G0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:26:13 -0400
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: BUG: warning at fs/inotify.c:405/set_dentry_child_flags()
Date: Tue, 30 May 2006 08:26:09 +0200
User-Agent: KMail/1.9.1
Cc: ttb@tentacle.dhs.org, rml@novell.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605300826.09502.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI

I haven't investigated nearer.

Got this on my workstation running 2.6.17rc4-git9 over night:

BUG: warning at linux/fs/inotify.c:405/set_dentry_child_flags()

Call Trace: <ffffffff80286112>{set_dentry_child_flags+100}
       <ffffffff80286498>{remove_watch_no_event+100} 
<ffffffff8028682a>{sys_inotify_rm_watch+186}
       <ffffffff8020954e>{system_call+126}

-Andi
