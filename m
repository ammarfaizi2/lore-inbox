Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265917AbTGILEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 07:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268143AbTGILEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 07:04:24 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:9133 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S265917AbTGILEY (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 07:04:24 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.64037.211787.63647@laputa.namesys.com>
Date: Wed, 9 Jul 2003 15:19:01 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 1/5 VM changes: zone-pressure.patch
In-Reply-To: <20030709034251.6902c488.akpm@osdl.org>
References: <16139.54887.932511.717315@laputa.namesys.com>
	<20030709031203.3971d9b4.akpm@osdl.org>
	<16139.60502.110693.175421@laputa.namesys.com>
	<20030709034251.6902c488.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > >  > OK, fixes a bug.
 > > 
 > >  What bug?
 > 
 > Failing to consider mapped pages on the active list until the scanning
 > priority gets large.
 > 
 > I ran up your five patches on a 256MB box, running `qsbench -m 350'.  It got
 > all slow then the machine seized up.   I'll poke at it some.
 > 

Thanks for trying them out.

Nikita.
