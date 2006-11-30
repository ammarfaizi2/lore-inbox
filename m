Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936250AbWK3MGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936250AbWK3MGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936249AbWK3MGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:06:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6111 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S936250AbWK3MGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:06:44 -0500
Subject: Re: hrtimer.h
From: Arjan van de Ven <arjan@infradead.org>
To: Ariel =?ISO-8859-1?Q?Ch=FFffffe1vez?= Lorenzo <achavezlo@yahoo.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <248625.39629.qm@web26101.mail.ukl.yahoo.com>
References: <248625.39629.qm@web26101.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Thu, 30 Nov 2006 13:06:41 +0100
Message-Id: <1164888402.3233.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-30 at 01:42 +0100, Ariel Chÿffffe1vez Lorenzo wrote:
> Hi,
> 
> Since the kernel 2.6.18 has incorporated the high
> resolution timer itself, I'm trying to test it, but on
> my GNU/Debian I can't figure out how to include
> hrtimer.h, that is on /usr/src/linux/include/, the
> headers.
> 
> I use the following command to try to compile it.
> 
> gcc -D__KERNEL__ -I /usr/src/linux/include ex.c


never use __KERNEL__ for userspace programs!


