Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVLMINa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVLMINa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVLMINa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:13:30 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:168 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S1751341AbVLMINa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:13:30 -0500
Date: Tue, 13 Dec 2005 09:13:05 +0100 (CET)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub5.ifh.de
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Decrease number of pointer derefs in flexcop-fe-tuner.c
In-Reply-To: <200512082335.55331.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0512130911160.27293@pub5.ifh.de>
References: <200512082335.55331.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

Thank you for patch. I applied it to our v4l-dvb CVS.

On Thu, 8 Dec 2005, Jesper Juhl wrote:
> Here's a small patch to decrease the number of pointer derefs in
> drivers/media/dvb/b2c2/flexcop-fe-tuner.c
>
> Benefits of the patch:
> - Fewer pointer dereferences should make the code slightly faster.
> - Size of generated code is smaller
> - Improved readability
>
> Please consider applying.

best regards,
Patrick.

--
   Mail: patrick.boettcher@desy.de
   WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
