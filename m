Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161461AbWJKVPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161461AbWJKVPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbWJKVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:15:00 -0400
Received: from outmx022.isp.belgacom.be ([195.238.4.203]:20884 "EHLO
	outmx022.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1161481AbWJKVOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:14:47 -0400
Date: Wed, 11 Oct 2006 23:14:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog/iTCO_wdt: fix bug related to gcc uninit warning
Message-ID: <20061011211439.GA3691@infomag.infomag.iguana.be>
References: <20061010074044.GA23501@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061010074044.GA23501@havoc.gtf.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

> gcc emits the following warning:
> 
> drivers/char/watchdog/iTCO_wdt.c: In function ‘iTCO_wdt_ioctl’:
> drivers/char/watchdog/iTCO_wdt.c:429: warning: ‘time_left’ may be used uninitialized in this function

Don't know how I missed that.
Anyway: patch applied to my linux-2.6-watchdog-mm tree.

Thanks,
Wim.

