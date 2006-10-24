Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWJXJI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWJXJI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWJXJI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:08:58 -0400
Received: from mx1.suse.de ([195.135.220.2]:23473 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030246AbWJXJI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:08:58 -0400
Date: Tue, 24 Oct 2006 11:08:55 +0200
From: Karsten Keil <kkeil@suse.de>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
       akpm@osdl.org
Subject: Re: [PATCH -mm] isdn/gigaset: use bitrev8
Message-ID: <20061024090855.GA32294@pingi.kke.suse.de>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai.germaschewski@gmx.de>,
	Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
	akpm@osdl.org
References: <20061024085657.GD7703@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024085657.GD7703@localhost>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 05:56:57PM +0900, Akinobu Mita wrote:

OK from my side.

> Use bitrev8 for gigaset isdn driver.
> 
> Cc: Karsten Keil <kkeil@suse.de>

Acked-by: Karsten Keil <kkeil@suse.de>

> Cc: Kai Germaschewski <kai.germaschewski@gmx.de>
> Cc: Hansjoerg Lipp <hjlipp@web.de>
> Cc: Tilman Schmidt <tilman@imap.cc>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
>  drivers/isdn/gigaset/Kconfig     |    1 +
>  drivers/isdn/gigaset/asyncdata.c |    5 +++--
>  drivers/isdn/gigaset/common.c    |   37 -------------------------------------
>  drivers/isdn/gigaset/gigaset.h   |    4 ----
>  drivers/isdn/gigaset/isocdata.c  |    5 +++--
>  5 files changed, 7 insertions(+), 45 deletions(-)
> 
> Index: work-fault-inject/drivers/isdn/gigaset/common.c
...

-- 
Karsten Keil
SuSE Labs
ISDN development
