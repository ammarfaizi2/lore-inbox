Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbUD3P1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUD3P1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 11:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUD3P1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 11:27:36 -0400
Received: from vena.lwn.net ([206.168.112.25]:39064 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262896AbUD3P1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:27:35 -0400
Message-ID: <20040430152733.26569.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: More on 2.6.6-rc* boot failure
From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 30 Apr 2004 09:27:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those who missed the first episode: my x86_64 system goes into a mad
oops frenzy as soon as it tries to run init.  Having discovered
panic_on_oops, I can now actually read the system's complaint.  As it turns
out, the actual process and call chain is different every time.  The common
factors, however, are:

	General protection fault: 0000 [1]
	RIP: __switch_to+51
	Call trace ends with thread_return+0

Might that ring any bells with anybody, or suggest areas for further
investigation?

Thanks,

jon
