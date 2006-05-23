Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWEWOQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWEWOQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWEWOP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:15:59 -0400
Received: from aun.it.uu.se ([130.238.12.36]:11984 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932088AbWEWOP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:15:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17523.6413.711397.401340@alkaid.it.uu.se>
Date: Tue, 23 May 2006 16:15:41 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Mike Mason <mmlnx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nmi_watchdog default setting on i386 and x86_64
In-Reply-To: <44724DE3.2000209@us.ibm.com>
References: <44724DE3.2000209@us.ibm.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Mason writes:
 > Does anybody know the reasoning behind having nmi_watchdog turned off by 
 > default on i386 and on by default on x86_64.  I've heard that i386 had 
 > problems with false positives in the past, but that local apic watchdog 
 > may make that concern obsolete.

On i386 the problems are mainly hardware and BIOS. In particular,
lots of Dell laptops have capable hardware but broken BIOSen that
hang the machines if we try to enable anything sending performance
counter interrupts via the local APIC.

/Mikael
