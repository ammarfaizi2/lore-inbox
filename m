Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVLPWFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVLPWFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVLPWFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:05:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41688 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932525AbVLPWFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:05:25 -0500
Date: Fri, 16 Dec 2005 23:05:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andy Isaacson <adi@hexapodia.org>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Reduce nr of ptr derefs in fs/jffs2/summary.c
In-Reply-To: <20051216033435.GA21600@hexapodia.org>
Message-ID: <Pine.LNX.4.61.0512162304310.24996@yvahk01.tjqt.qr>
References: <20051216033435.GA21600@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Benefits:
>> > - micro speed optimization due to fewer pointer derefs
>> > - generated code is slightly smaller
>> 
>> Should not these two at best be done by the compiler?
>
>[...]
>But a human *can* make the obvious leap and tell the compiler that the
>value can be computed once and then saved.  And besides, isn't the code
>just *much* nicer to look at, above?

The third point Jesper mentioned was about readability, but I never 
questioned that.


Jan Engelhardt
-- 
