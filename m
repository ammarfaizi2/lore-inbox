Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbTGCKYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbTGCKYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:24:22 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:44025 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S265828AbTGCKYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:24:21 -0400
Subject: Re: dmesg problem in 2.5.73
From: Martin Schlemmer <azarah@gentoo.org>
To: John Covici <covici@ccs.covici.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <m3he64c7qo.fsf@ccs.covici.com>
References: <m3he64c7qo.fsf@ccs.covici.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057228803.5499.243.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 03 Jul 2003 12:40:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-03 at 10:52, John Covici wrote:
> Hi.  I have a weird problem -- maybe its iptables, but I am using the
> log target and they print at legvel 4, but I only want level 3 or
> less to print on the console, so I did 'dmesg -n 3' but I am still
> getting the iptables messages.
> 
> I thought I could do this all with syslog.conf, but that has never
> worked.
> 

Changing DEFAULT_CONSOLE_LOGLEVEL (?) has been broken since
2.5.70 or 2.5.71.  I checked kernel/printk.c, etc, but could
not see anything that was causing this.


Regards,

-- 
Martin Schlemmer


