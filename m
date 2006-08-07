Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWHGTjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWHGTjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWHGTjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:39:15 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:38557 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932323AbWHGTjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:39:14 -0400
Date: Mon, 7 Aug 2006 21:38:36 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
Subject: resume from S3 regression [Was: 2.6.18-rc3-mm2]
Message-ID: <20060807193836.GA4007@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc1-mm2-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after resume from ram (tested in single user), I can type commands for a
few seconds (time is variable), the processes get stuck in io_schedule.
Poorman's screenshots are here:
http://oioio.altervista.org/linux/dsc03448.jpg
http://oioio.altervista.org/linux/dsc03449.jpg

.config:
http://oioio.altervista.org/linux/config-2.6.18-rc3-mm2-1

Anything useful I could add?
-- 
mattia
:wq!
