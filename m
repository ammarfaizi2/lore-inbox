Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTL2RWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTL2RWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:22:33 -0500
Received: from luli.rootdir.de ([213.133.108.222]:10908 "EHLO luli.rootdir.de")
	by vger.kernel.org with ESMTP id S263777AbTL2RWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:22:31 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.20 (Clear:RC:1(217.186.137.237):SA:0(-4.4/5.0):. Processed in 0.307419 secs)
Date: Mon, 29 Dec 2003 18:22:26 +0100
From: Claas Langbehn <claas@rootdir.de>
To: craig duncan <duncan@nycap.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD burn buffer underruns on 2.6
Message-ID: <20031229172226.GA2741@rootdir.de>
References: <16366.60194.935861.592797@nycap.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16366.60194.935861.592797@nycap.rr.com>
Reply-By: Do Jan  1 18:19:04 CET 2004
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0 i686
X-No-archive: yes
X-Uptime: 18:19:04 up  8:16,  6 users,  load average: 0.07, 0.14, 0.14
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


ide-scsi is deprecated and should not be used
any longer. Instead you should use the ide 
device directly. F.ex.

cdrecord dev=dev/hdc ...

But as far as i know, cdrdao does not support
this yet :(


When I was trying to burn with ide-scsi earlier
in 2.6.0-testX, I also had lockups. I think if
you need to use cdrdao, then you might better 
stick to 2.4.x kernels until cdrdao learns it.


regards,
claas
