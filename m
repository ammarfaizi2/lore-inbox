Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752082AbWFWVas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbWFWVas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbWFWVas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:30:48 -0400
Received: from quechua.inka.de ([193.197.184.2]:35473 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1752082AbWFWVar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:30:47 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 1/2] introduce crashboot kernel command line parameter
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060623210121.GA18384@in.ibm.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FttEj-0002JH-00@calista.eckenfels.net>
Date: Fri, 23 Jun 2006 23:30:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
> +static int __init set_crash_boot(char *str)
> +{
> +       crash_boot = 1;
> +       return 1;
> +}

what about a printk? Maybe a combined one which shows some other stuff (init
level, init shell, apic settings) etc from command line.

Gruss
Bernd
