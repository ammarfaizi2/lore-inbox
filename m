Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264662AbUD1Fdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264662AbUD1Fdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUD1Fdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:33:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:20715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264662AbUD1Fdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:33:43 -0400
Date: Tue, 27 Apr 2004 22:33:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: brettspamacct@fastclick.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to tune pdflush?
Message-Id: <20040427223323.07de3270.akpm@osdl.org>
In-Reply-To: <408EEBAF.7020603@fastclick.com>
References: <408EEBAF.7020603@fastclick.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brett E." <brettspamacct@fastclick.com> wrote:
>
> I would like to tune pdflush so the writeback isn't too greedy, right 
>  now the system is unusable due to high disk I/O after creating a bunch 
>  of files. I know, faster disks would be better.. Tuning the writeback 
>  would also be a nice option, we had it in 2.4 with /proc/sys/vm/bdflush.

The tunables in /proc/sys/vm are documented in
Documentation/filesystems/proc.txt
