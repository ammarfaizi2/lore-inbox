Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287983AbSAMCyS>; Sat, 12 Jan 2002 21:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287880AbSAMCyI>; Sat, 12 Jan 2002 21:54:08 -0500
Received: from quint.netisland.net ([207.8.132.210]:58641 "EHLO
	quint.netisland.net") by vger.kernel.org with ESMTP
	id <S287950AbSAMCyE>; Sat, 12 Jan 2002 21:54:04 -0500
Date: Sat, 12 Jan 2002 21:54:02 -0500
From: "Michael C. Toren" <mct@toren.net>
To: linux-kernel@vger.kernel.org
Subject: acquire_console_sem exported, but not release_console_sem?
Message-ID: <20020112215402.A3254@quint.netisland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In kernel/printk.c, it looks like acquire_console_sem() is exported, but
not release_console_sem()?  Is this intentional, or just an oversight?

Thanks,

-mct
