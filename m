Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262002AbSI3KPM>; Mon, 30 Sep 2002 06:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSI3KPM>; Mon, 30 Sep 2002 06:15:12 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:43282 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S262002AbSI3KPL>;
	Mon, 30 Sep 2002 06:15:11 -0400
To: linux-kernel@vger.kernel.org
Subject: Failed build on Alpha with binutils 2.13
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 30 Sep 2002 12:20:35 +0200
Message-ID: <yw1xlm5jok24.fsf@tophat.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling the kernel on an Alpha with binutils 2.13, everything
works fine, until the final 'depmod' in the end of 'make modules'.  It
fails with lots of unresolved symbols.  Relinking the kernel with
binutils 2.12 solves it.  What's going on?  Is it being fixed?

-- 
Måns Rullgård
mru@users.sf.net
