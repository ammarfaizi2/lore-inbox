Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWIJUAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWIJUAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWIJUAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:00:14 -0400
Received: from bbr254.neoplus.adsl.tpnet.pl ([83.27.207.254]:48793 "EHLO
	Jerry.zjeby.dyndns.org") by vger.kernel.org with ESMTP
	id S964834AbWIJUAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:00:13 -0400
Date: Sun, 10 Sep 2006 21:59:34 +0200 (CEST)
From: Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org>
To: Pavel Machek <pavel@ucw.cz>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: swsusp problem
In-Reply-To: <20060910194955.GA1841@elf.ucw.cz>
Message-ID: <Pine.LNX.4.63.0609102158220.2685@Jerry.zjeby.dyndns.org>
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org>
 <200609101133.32931.rjw@sisk.pl> <Pine.LNX.4.63.0609102123080.2685@Jerry.zjeby.dyndns.org>
 <20060910192716.GB5308@elf.ucw.cz> <Pine.LNX.4.63.0609102137240.2685@Jerry.zjeby.dyndns.org>
 <20060910194955.GA1841@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It should die with
5B>
>        if (!cpu_has_pse) {
>                printk(KERN_ERR "PSE is required for swsusp.\n");
>                return -EPERM;
>        }
>
> ...can you investigate why it does not?

obviously because i disabled BUG() support :o

thanx for help

-- 

