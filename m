Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267874AbTGLROw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 13:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267981AbTGLROv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 13:14:51 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:59609
	"EHLO jumper") by vger.kernel.org with ESMTP id S267874AbTGLROv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 13:14:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: hang with pcmcia wlan card
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi>
	<873chbyasi.fsf@jumper.lonesom.pp.fi>
	<20030712173039.A17432@flint.arm.linux.org.uk>
	<20030712164855.GB2133@gmx.de>
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Sat, 12 Jul 2003 20:30:25 +0300
In-Reply-To: <20030712164855.GB2133@gmx.de> (Wiktor Wodecki's message of
 "Sat, 12 Jul 2003 18:48:55 +0200")
Message-ID: <87y8z3wt3i.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor Wodecki <wodecki@gmx.de> writes:

> well, at least it is this changeset for me (same problem)
>
>> --- linux-2.5.73-bk1/drivers/pcmcia/ti113x.h  2003-06-22 11:32:41.000000000 -0700
>> +++ linux-2.5.73-bk2/drivers/pcmcia/ti113x.h  2003-06-24 13:06:59.000000000 -0700

 Yes, confirmed. Backing off this makes things work again.

                      --j
