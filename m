Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVEKCE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVEKCE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 22:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEKCEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 22:04:21 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:64418 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261880AbVEKCEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 22:04:15 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
To: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Reply-To: 7eggert@gmx.de
Date: Wed, 11 May 2005 04:04:11 +0200
References: <41iyE-8mI-11@gated-at.bofh.it> <427KM-h4-9@gated-at.bofh.it> <42pRx-75A-19@gated-at.bofh.it> <42znJ-6x7-25@gated-at.bofh.it> <42zQL-70r-25@gated-at.bofh.it> <42CF0-YV-37@gated-at.bofh.it> <42GIH-4u3-31@gated-at.bofh.it> <42Jn3-6Qj-5@gated-at.bofh.it> <42KsY-7KW-33@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DVga4-0001g7-4s@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta <bilotta78@hotpop.com> wrote:

> Is there a way to control the order in which modules get loaded? For
> example, I usually blacklist the parport module and only load it when
> I need it, thus freeing an IRQ (for audio, IIRC). If parport loads
> automatically, it grabs the IRQ; if it loads after the IRQ is grabbed
> already, it'll resort to polled mode. Can these things be controlled
> without the blacklist?

Documentation/parport.txt

The rest should be configurable in /etc/mod{ules,probe}.conf
-- 
Top 100 things you don't want the sysadmin to say:
69. ``Why is my "rm *.o" taking so long?''

