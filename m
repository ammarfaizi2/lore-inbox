Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272157AbTHKFxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272159AbTHKFxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:53:48 -0400
Received: from wombat.cs.rmit.edu.au ([131.170.24.41]:47775 "EHLO
	wombat.cs.rmit.edu.au") by vger.kernel.org with ESMTP
	id S272157AbTHKFxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:53:47 -0400
Message-ID: <3F372F68.99C02861@operamail.com>
Date: Mon, 11 Aug 2003 15:53:44 +1000
From: Malcolm Smith <msmith@operamail.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS server issues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble with 2.6.0-test2's NFS support.  The problem has
existed for a few releases (not sure how far back.)

I'm using NFSv3 over UDP.  Every time a client makes an NFS mount, the
previous mount is silently dropped.  The client assumes that both mounts
are current, but only the more recent mount is functional.

Is this behaviour intentional?  Has anybody else experienced it?  2.4.x
is not affected.

- M
http://yallara.cs.rmit.edu.au/~malsmith/

