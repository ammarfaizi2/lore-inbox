Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUKHMUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUKHMUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUKHMUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:20:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:60942 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261568AbUKHMUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:20:14 -0500
Subject: Re: problem booting SMP kernel !
From: Arjan van de Ven <arjan@infradead.org>
To: Rajendra <rpm@solidcore.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003401c4c55b$168ece50$6f52a8c0@rpm>
References: <003401c4c55b$168ece50$6f52a8c0@rpm>
Content-Type: text/plain
Message-Id: <1099916407.3577.12.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 08 Nov 2004 13:20:07 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 14:20 +0800, Rajendra wrote:
> Hi ,
>    I have been trying to boot an SMP kernel (2.4.20 redhat) on my laptop

RH has no 2.4.20 in production anymore; sounds like you're using an
oldie

> (Dell Inspiron 5160) without any success.
> It has hyper-threaded processor (Pentium IV 3.0 GHz - HT). 2.6.5 kernel is
> booting fine and is able to detect the
> Hyperthreading and initilize it and I can see two processors in my
> /proc/cpuinfo with 2.6.5 booted up.

sounds like you should use the 2.6 kernel; it could well be an ACPI
related issue (eg lack of acpi :)


