Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUJFGtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUJFGtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUJFGtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:49:10 -0400
Received: from quechua.inka.de ([193.197.184.2]:8167 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S268325AbUJFGtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:49:09 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: block till hotplug is done?
Date: Wed, 06 Oct 2004 00:04:54 +0200
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2004.10.05.22.04.54.237116@dungeon.inka.de>
References: <1097005927.4953.4.camel@simulacron> <4163005B.2090000@t-online.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2004 20:19:59 +0000, Harald Dunkel wrote:
> while [ "`ps | grep /sbin/hotplug | grep -v grep`" ]; do sleep 1; done

wouldn't work in case the hotplug bug uses exec(), right?

Andreas

