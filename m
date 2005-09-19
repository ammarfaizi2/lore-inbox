Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbVISVs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbVISVs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVISVs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:48:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:38120 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932660AbVISVs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:48:28 -0400
Subject: Re: I request inclusion of reiser4 in the mainline kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: stephen.pollei@gmail.com, Alexander Zarochentcev <zam@namesys.com>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
In-Reply-To: <17199.10558.939696.765980@gargle.gargle.HOWL>
References: <432AFB44.9060707@namesys.com>
	 <200509171416.21047.vda@ilport.com.ua>
	 <17197.15183.235861.655720@gargle.gargle.HOWL>
	 <feed8cdd05091912362ac13f3e@mail.gmail.com>
	 <17199.10558.939696.765980@gargle.gargle.HOWL>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 07:47:33 +1000
Message-Id: <1127166454.4386.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Maybe, but kernel developers are supposed to watch for compiler
> messages. People who use that technique definitely do.

You are making no sense. If the function isn't defined, it will break at
link time or depmod time instead of compile time, big deal... get rid of
those useless #ifdef's please.

Ben.


