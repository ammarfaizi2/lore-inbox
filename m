Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTJROgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 10:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTJROgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 10:36:47 -0400
Received: from natsmtp01.rzone.de ([81.169.145.166]:59844 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261606AbTJROgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 10:36:46 -0400
Message-ID: <3F915007.7040709@gmx.de>
Date: Sat, 18 Oct 2003 16:36:55 +0200
From: Alwin Meschede <ameschede@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: de-de, de, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IPv6 module broken in 2.6.0-test8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the ipv6 module of 2.6.0-test8 is not loadable because of an unknown 
symbol __secpath_destroy. I think this is related to the "Clear security 
path for tunnel packets" patch by herbert@gondor.apana.org.au

Might someone have a look at it?

Alwin Meschede

