Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWIXXA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWIXXA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 19:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWIXXA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 19:00:28 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:36757 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932271AbWIXXA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 19:00:27 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-mm1 make oldconfig missed SATA
Date: Mon, 25 Sep 2006 09:00:22 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <n73eh2d2ido2oimfqn798hp029lshga5qf@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

2.6.18-mm1 make oldconfig didn't pull SATA config from 2.6.18 old screen to 
the new libata screen, caught me out -- this may be an issue for 2.6.19 
upgraders that a quick make oldconfig rebuild will fail to boot?

Grant.
