Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWBAPVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWBAPVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWBAPVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:21:30 -0500
Received: from quechua.inka.de ([193.197.184.2]:59096 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1161090AbWBAPV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:21:29 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200601301428.50220.vda@ilport.com.ua>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1F4JnT-0004pE-00@calista.inka.de>
Date: Wed, 01 Feb 2006 16:21:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> wrote:
> # umount /.3
> umount: /.3: device is busy
> # lsof -nP | grep -F '/.3'
> # lsof -nP | grep -F 'sdc'

You can try "lsof +f -- /.3" also

Gruss
Bernd
