Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946037AbWGPAhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946037AbWGPAhc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946058AbWGPAhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:37:32 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:55729 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1946037AbWGPAhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:37:31 -0400
Message-ID: <44B989FA.5060600@t-online.de>
Date: Sun, 16 Jul 2006 02:36:10 +0200
From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] [PULL]saa7134: rename dmasound_{init,
 exit}
References: <20060715003710.GO3633@stusta.de>
In-Reply-To: <20060715003710.GO3633@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EB7IarZvgeAIpF6yd8b7q77zOI1Tf1wrMsOI8pnQ2Wn9nwfRT73bZK
X-TOI-MSGID: 06e740c2-ac15-40e4-a467-102cf2ece180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Adrian Bunk wrote:
> Two different exports with the same name are not a good idea:
> 
> $ grep -r EXPORT_SYMBOL\(dmasound_init\) *
> drivers/media/video/saa7134/saa7134-core.c:EXPORT_SYMBOL(dmasound_init);
> sound/oss/dmasound/dmasound_core.c:EXPORT_SYMBOL(dmasound_init);
> $ 
> 
> This patch renames the saa7134 dmasound_{init,exit} to 
> saa7134_dmasound_{init,exit}.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
<snip>

I applied the patch to my personal repository.

Mauro, can you please pull?

Hartmut
