Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTHZBHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 21:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTHZBHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 21:07:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2021 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262368AbTHZBHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 21:07:13 -0400
Message-ID: <3F4AB2AB.5090709@pobox.com>
Date: Mon, 25 Aug 2003 21:06:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, m.c.p@wolk-project.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow sysrq() via /proc/sys/kernel/magickey
References: <200308252003.h7PK3EQq024312@hera.kernel.org>
In-Reply-To: <200308252003.h7PK3EQq024312@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1114, 2003/08/25 16:42:57-03:00, m.c.p@wolk-project.de
> 
> 	[PATCH] Allow sysrq() via /proc/sys/kernel/magickey
> 	
> 	Hi Marcelo,
> 	
> 	sysrq() is a good thing to debug things, but unfortunately you need to have
> 	physical access to the keyboard. My company for instance maintains tons of
> 	remote machines and sometimes we need to do sysrq() too, but it's not
> 	possible to do so the remote way.
> 	
> 	Attached patch enables emulation of the Magic SysRq key (Alt-SysRq-key) via
> 	the /proc interface. Just echo the desired character into the file and there
> 	you go.
> 	
> 	Patch from Randy Dunlap!


This patch is completely unneeded and redundant.

2.4.x already has /proc/sysrq-trigger for precisely this purpose.

See fs/proc/proc_misc.c for more details.

	Jeff



