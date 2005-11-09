Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVKITQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVKITQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVKITQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:16:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59043 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030311AbVKITQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:16:52 -0500
Message-ID: <43724AB3.40309@redhat.com>
Date: Wed, 09 Nov 2005 11:14:59 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: openat()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can we please get the openat() syscall implemented?  I know Linus 
already declared this is a good idea and I can only stress that it is 
really essential for some things.  It is today impossible to write 
correct code which uses long pathnames since all these operations would 
require the use of chdir() which affect the whole POSIX process and not 
just one thread.  In addition we have the reduction of race conditions.

I remember having seen an implementation at some time.  Can somebody dig 
it up?  If there is nothing available I'll try to get some code submitted.

I'm ignoring the discussions about alternative streams for files here, 
so don't bother arguing with the.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
