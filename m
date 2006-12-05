Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968443AbWLEQcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968443AbWLEQcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968444AbWLEQcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:32:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60580 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968443AbWLEQca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:32:30 -0500
Subject: Re: irq/0/smp_affinity =3 doesn't seem to work
From: Arjan van de Ven <arjan@infradead.org>
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5d96567b0612050830s1b0c0708s3f796d85227f1285@mail.gmail.com>
References: <5d96567b0612050830s1b0c0708s3f796d85227f1285@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 05 Dec 2006 17:32:26 +0100
Message-Id: <1165336346.3233.382.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 18:30 +0200, Raz Ben-Jehuda(caro) wrote:
> hello.
> 
> I have a dual cpu AMD machine, I noticed that
> only one timer0 is working in /proc/interrutps.
> setting proc/irq/0/smp_affinity to 3 does make
> any difference.

if you set it to 3 then the chipset gets to decide where the irq goes.
Many decide to send it to the first cpu. 

(not that it matters, the timer is so low frequency that it can go
anywhere without problems)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

