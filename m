Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbTC3XkO>; Sun, 30 Mar 2003 18:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbTC3XkO>; Sun, 30 Mar 2003 18:40:14 -0500
Received: from almesberger.net ([63.105.73.239]:6925 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261316AbTC3XkO>; Sun, 30 Mar 2003 18:40:14 -0500
Date: Sun, 30 Mar 2003 20:51:26 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: PTRACE_KILL doesn't (2.5.44 and others)
Message-ID: <20030330205126.G7414@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the process being ptraced is running, PTRACE_KILL will have no
effect. I've seen this in 2.5.44, and the code in 2.4.18 and 2.5.66
seems to be equivalent.

According to the ptrace(2) man page (as of man-pages-1.56),
PTRACE_KILL doesn't require the process to be stopped for this to
work.

Who is right ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
