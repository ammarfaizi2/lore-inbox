Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270982AbTHBCFI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 22:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270984AbTHBCFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 22:05:08 -0400
Received: from www.13thfloor.at ([212.16.59.250]:48566 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270982AbTHBCFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 22:05:05 -0400
Date: Sat, 2 Aug 2003 04:05:13 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: are circular dependencies in again?
Message-ID: <20030802020512.GB16814@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All!

just observed a bunch of circular dependencies 
while compiling 2.4.22-pre10 ...

include/asm/smplock.h <- include/linux/interrupt.h
include/asm/hw_irq.h <- include/linux/smp_lock.h

is this something I should get used to, or
just a small glitch in the matrix ;) ...

TIA,
Herbert

