Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUGNO3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUGNO3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267395AbUGNO2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:28:51 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:46526 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267389AbUGNOZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:25:49 -0400
Message-ID: <40F5427B.30901@eidetix.com>
Date: Wed, 14 Jul 2004 16:26:03 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: tcp connections dropped in 2.6.7
References: <40F411B6.10200@eidetix.com> <20040713170036.GD23026@piscue.com> <40F41866.2060305@eidetix.com> <40F42662.7010203@ihug.com.au>
In-Reply-To: <40F42662.7010203@ihug.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies to me.  Thanks! ]

Checked the cabling and switch and that wasn't it either.

This seems related to what I was seeing:

https://qa.mandrakesoft.com/show_bug.cgi?id=1546

I recompiled the realtek nic driver to show me debugging information,
and in fact, it wasn't even showing interrupts on pings during the 'outage'.

If anyone has ideas on how to track down the buggy software, I'm willing
to try them out, but I don't have the know-how to chase this down on my
own.  Maybe it's a known problem and already being worked on...

Thankyou,
-- 
David N. Welton
davidw@eidetix.com

