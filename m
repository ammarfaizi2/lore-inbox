Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWJXU4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWJXU4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWJXU4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:56:33 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:4028 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965196AbWJXU4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:56:32 -0400
Date: Tue, 24 Oct 2006 22:55:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
Message-ID: <20061024205503.GA23078@wohnheim.fh-wedel.de>
References: <45324658.1000203@gmail.com> <20061016133352.GA23391@lst.de> <200610242124.49911.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610242124.49911.arnd@arndb.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 October 2006 21:24:49 +0200, Arnd Bergmann wrote:
>
> ./drivers/mtd/mtd_blkdevs.c:    ret = kernel_thread(mtd_blktrans_thread, tr, CLONE_KERNEL);

This one should be ripped out.  I did it as part of a bugfix for a
customer kernel not too long ago.

Jörn

-- 
Joern's library part 3:
http://inst.eecs.berkeley.edu/~cs152/fa05/handouts/clark-test.pdf
