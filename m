Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTIJKnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbTIJKnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:43:39 -0400
Received: from imap.gmx.net ([213.165.64.20]:51659 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261917AbTIJKnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:43:37 -0400
Message-Id: <6.0.0.22.0.20030910124128.01c40cc0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Wed, 10 Sep 2003 12:47:39 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Priority Inversion in Scheduling
Cc: Mike Fedyk <mfedyk@matchmail.com>, John Yau <jyau_kernel_dev@hotmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3F5EEEDA.7070406@cyberone.com.au>
References: <LAW10-OE63Zc1WPsAVe0000ab93@hotmail.com>
 <3F5E6F15.6040507@cyberone.com.au>
 <6.0.0.22.0.20030910062610.01cfacd8@pop.gmx.net>
 <20030910053549.GE28279@matchmail.com>
 <6.0.0.22.0.20030910074121.01c8a220@pop.gmx.net>
 <3F5EEEDA.7070406@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:28 AM 9/10/2003, Nick Piggin wrote:

>Sounds interesting. I my scheduler doesn't have any inversion or
>starvation issues that I know of without backboost though. I'd like to
>know if you find any.

I haven't been able to stimulate inversion, or found any terminal 
starvation with your mods.  The only things I can see is array switch 
latency making X choppy under load, and the cpu distribution differences 
shown by contest (and both may have changed considerably since last version 
tested).

         -Mike 

