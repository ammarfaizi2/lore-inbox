Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266021AbUFVV7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUFVV7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUFVV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:58:57 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:46330 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265114AbUFVV4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:56:09 -0400
Date: Tue, 22 Jun 2004 17:49:23 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NET]: Fix dev_queue_xmit build with older gcc.
In-Reply-To: <40D899E6.5060409@pobox.com>
Message-ID: <Pine.GSO.4.33.0406221746580.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Jeff Garzik wrote:
>Has this been tested with preempt?
>
>It looks right, but I'm paranoid...

It has now.  Prior to my last bk pull (a few minutes ago), there were all
number of preempt problems leading to scheduling while atomic.  They
appear to be fixed now.

--Ricky


