Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbUBBDzN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 22:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUBBDzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 22:55:13 -0500
Received: from nevyn.them.org ([66.93.172.17]:41094 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265597AbUBBDzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 22:55:11 -0500
Date: Sun, 1 Feb 2004 22:55:08 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Cc: roland@redhat.com
Subject: 2.6.2-rc3 broke ptrace in the vsyscall dso area
Message-ID: <20040202035508.GA10286@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, roland@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My last kernel was unfortunately 2.6.0-test7, so I can't say exactly when
this broke.  But suddenly I get:

ptrace(PTRACE_PEEKTEXT, 10259, 0xffffe000, [0xbfffe948]) = -1 EIO (Input/output error)
ptrace(PTRACE_PEEKTEXT, 10259, 0xffffe000, [0xbfffe948]) = -1 EIO (Input/output error)

Any idea what might have disabled this?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
