Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbVISWBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbVISWBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVISWBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 18:01:13 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:38537 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932634AbVISWBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 18:01:11 -0400
Message-ID: <432F3524.101@namesys.com>
Date: Mon, 19 Sep 2005 15:01:08 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: stephen.pollei@gmail.com, Alexander Zarochentcev <zam@namesys.com>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com>	<200509171416.21047.vda@ilport.com.ua>	<17197.15183.235861.655720@gargle.gargle.HOWL>	<feed8cdd05091912362ac13f3e@mail.gmail.com> <17199.10558.939696.765980@gargle.gargle.HOWL>
In-Reply-To: <17199.10558.939696.765980@gargle.gargle.HOWL>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>
>It's enough to monitor your own code, rather than the whole kernel.
>  
>
To this I would add, the kernel should not have warnings when it
compiles.  Now THAT is a style requirement I would rigorously enforce if
I could.  I deeply regret that long ago there was a Linux scsi driver
author who left a warning in, and then after that they started
multiplying throughout the kernel.  It makes users much more confident
when they patch the kernel if there are no warnings that leave them
wondering if the new patch created the warning or if it was there before.

Hans
