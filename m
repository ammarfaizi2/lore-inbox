Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRJaV5g>; Wed, 31 Oct 2001 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRJaV51>; Wed, 31 Oct 2001 16:57:27 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:58621 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S273881AbRJaV5Q>; Wed, 31 Oct 2001 16:57:16 -0500
Message-ID: <3BE073B6.BDCB3D56@redhat.com>
Date: Wed, 31 Oct 2001 16:57:10 -0500
From: Bob Matthews <bmatthews@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Stress testing 2.4.14-pre6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We've been doing some stress-testing on 2.4.14-pre6 and have encountered
a couple of problems.  The platform is an 8xPIII with 8G RAM and 32G
swap.  After running Cerberus for about 3 hours, the machine hung
completely.  I was not able to switch VC's.

Unfortunately, this is as detailed a bug report as I can submit.  It
looks like Magic SysRq is broken in this kernel.  <alt><SysRq>T will
print the column headings but nothing else.
-- 
Bob Matthews
Red Hat, Inc.
