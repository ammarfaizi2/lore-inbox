Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbTJUM4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 08:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTJUM4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 08:56:53 -0400
Received: from mail.convergence.de ([212.84.236.4]:55244 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263083AbTJUM4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 08:56:51 -0400
Message-ID: <3F952D0F.7020109@convergence.de>
Date: Tue, 21 Oct 2003 14:56:47 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ranty@debian.org
CC: Andrew Morton <akpm@osdl.org>, Marcel Holtmann <marcel@holtmann.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Proposal to remove workqueue usage from request_firmware_async()
References: <20031020235355.GA3068@ranty.pantax.net>
In-Reply-To: <20031020235355.GA3068@ranty.pantax.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Manuel,

>  How does this look?
>  Interested parties please test and comment.

I updated my patch for the av7110 DVB driver from LinuxTV.org and I can 
confirm that it works very well.

Recent updates are in
http://linuxtv.org/cgi-bin/cvsweb.cgi/dvb-kernel/patches-2.6/

I usually set the timeout value to "60" and then manually load the 
firmware. Everything is ok, IMHO this patch can be submitted.

CU
Michael.

