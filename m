Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbVINNpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbVINNpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVINNpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:45:30 -0400
Received: from ptb-relay01.plus.net ([212.159.14.212]:225 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S965187AbVINNp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:45:29 -0400
Date: Wed, 14 Sep 2005 14:45:45 +0100
From: Ash Milsted <thatistosayiseenem@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Voluntary Preempt blocks mount events from HAL
Message-Id: <20050914144545.38b14abf.thatistosayiseenem@gawab.com>
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. 
With the 2.6.14-rc1 and 2.6.13 kernels, voluntary preempt seems to
prevent HAL from detecting changes in the mount state of any given
volume. Changing the preempt option to None or Full fixes the problem.

I have tested this on my Athlon XP system with HAL 0.5.4. This issue
screws up desktop environments that use HAL to test mount states.
Anyone else seeing this?

-Ash
