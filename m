Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVIOAz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVIOAz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVIOAz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:55:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16303 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030273AbVIOAz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:55:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Sripathi Kodi <sripathik@in.ibm.com>
X-Fcc: ~/Mail/linus
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       patrics@interia.pl, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
In-Reply-To: Sripathi Kodi's message of  Wednesday, 14 September 2005 19:31:12 -0500 <4328C0D0.6000909@in.ibm.com>
X-Shopping-List: (1) Spastic bog proteins
   (2) Irritating scorpions
   (3) Meretricious rigorous burgers
Message-Id: <20050915005552.38626180A1A@magilla.sf.frob.com>
Date: Wed, 14 Sep 2005 17:55:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you don't like this idea at all, please let me know if there any other 
> way of solving the invisible threads problem, short of taking out 
> ->permission() altogether from proc_task_inode_operations.

Have you investigated my suggestion to move __exit_fs from do_exit to
release_task?


Thanks,
Roland
