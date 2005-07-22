Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVGVSpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVGVSpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVGVSpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:45:00 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:25055 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261342AbVGVSo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:44:59 -0400
Date: Fri, 22 Jul 2005 20:44:39 +0200
From: Voluspa <lista1@telia.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: jesper.juhl@gmail.com, lista1@telia.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-Id: <20050722204439.54a63a00.lista1@telia.com>
In-Reply-To: <20050722180236.GA615@atrey.karlin.mff.cuni.cz>
References: <20050721200448.5c4a2ea0.lista1@telia.com>
	<9a8748490507211114227720b0@mail.gmail.com>
	<20050722144855.GA2036@elf.ucw.cz>
	<20050722191510.5e120515.voluspa@telia.com>
	<20050722180236.GA615@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005 20:02:36 +0200 Pavel Machek wrote:
> will not help. It seems like your machine is simply not able to do
> reasonable powersaving.

Digging up this patch from last month regarding C2 on a AMD K7 implies
that the whole blame can be put on kernel acpi:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111933745131301&w=2

Mvh
Mats Johannesson
--
