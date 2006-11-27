Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758194AbWK0NYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194AbWK0NYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758196AbWK0NYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:24:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10424 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758194AbWK0NYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:24:42 -0500
Date: Mon, 27 Nov 2006 13:30:44 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: avl@logic.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: hpa-problem in ide-disk.c - new insights.
Message-ID: <20061127133044.28b8b4ed@localhost.localdomain>
In-Reply-To: <20061127130953.GA2352@gamma.logic.tuwien.ac.at>
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at>
	<20061120152505.5d0ba6c5@localhost.localdomain>
	<20061120165601.GS6851@gamma.logic.tuwien.ac.at>
	<20061120172812.64837a0a@localhost.localdomain>
	<20061121115117.GU6851@gamma.logic.tuwien.ac.at>
	<20061121120614.06073ce8@localhost.localdomain>
	<20061122105735.GV6851@gamma.logic.tuwien.ac.at>
	<20061123170557.GY6851@gamma.logic.tuwien.ac.at>
	<20061127130953.GA2352@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 14:09:53 +0100
Andreas Leitgeb <avl@logic.at> wrote:

> It appears, as if the drive is really approaching breakdown, 
> remapping bad sectors and is out of spare sectors. Thus

HPA has nothign to do with sector remapping. HPA simply allows the BIOS
(or disk by jumper option) to hide part of the drive early in boot so
that it doesn't confuse/break old OS/BIOS code, or to use it to hide
things like windows reinstall images.

Alan
