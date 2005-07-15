Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVGOWap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVGOWap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVGOWao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:30:44 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:33673 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262118AbVGOW3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:29:23 -0400
Message-ID: <42D838CC.7080003@brturbo.com.br>
Date: Fri, 15 Jul 2005 19:29:32 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, John Klar <linpvr@projectplasma.com>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [2.6 patch] drivers/media/video/tveeprom.c: possible cleanups
References: <20050715213512.GI18059@stusta.de>
In-Reply-To: <20050715213512.GI18059@stusta.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

	Your patch is at my personal TODO list.

	We had lots of patches for 2.6.13, with some sigificative enhancements.

	Unfortunatelly, your patch from 19 Apr 2005 was not applied, maybe
because you've sent during a period where V4L was Orphaned.

	We've decided to stop non-bug fixes just some days before your newer
attempt (July, 7) to focus on more tests at a stable branch. Until July,
18, V4L are applying only bug fixes. After that, we'll collect more
patches at V4L and, maybe at the end of the next week, we'll send the
patchsets, including yours (It will be #1 :-) ).

Cheers,

Mauro.

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make two needlessly global structs static
> - #if 0 the EXPORT_SYMBOL'ed but unused function tveeprom_dump
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 9 Jul 2005
> - 19 Apr 2005
> 

