Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261586AbSJQAul>; Wed, 16 Oct 2002 20:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261587AbSJQAul>; Wed, 16 Oct 2002 20:50:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41398 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261586AbSJQAul>;
	Wed, 16 Oct 2002 20:50:41 -0400
Date: Wed, 16 Oct 2002 17:49:18 -0700 (PDT)
Message-Id: <20021016.174918.125874029.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: non-modversions GPLONLY_
From: "David S. Miller" <davem@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If we export the symbol as GPLONLY_dequeue_signal (for example), yet
don't use modversions to mangle the GPLONLY_ prefix to the symbol for
what code actually uses to access the symbol, what makes this work?

Is there some magic in newer versions of modutils which does
this transparently? :-)

