Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318841AbSH1NlS>; Wed, 28 Aug 2002 09:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSH1NlS>; Wed, 28 Aug 2002 09:41:18 -0400
Received: from e.kth.se ([130.237.48.5]:34576 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S318841AbSH1NlR>;
	Wed, 28 Aug 2002 09:41:17 -0400
To: linux-kernel@vger.kernel.org
Subject: OOM strangeness
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 28 Aug 2002 15:45:37 +0200
Message-ID: <yw1xptw3xfjy.fsf@fruxo.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yesterday I was compiling some things with gcc 3.1.1.  When compiling
a rather large file with lots of optimizations, gcc was kill by the
OOM killer, even though I have 768 MB of ram and most of it was free.
Repeating the compilation succeeded.  GCC did use ~250 MB or so, but
that shouldn't be a problem.

What could be causing this?  A bug?  Kernel version is 2.4.19-rc3 with
superpage patch on an Alpha 164SX system.

-- 
Måns Rullgård
mru@users.sf.net
