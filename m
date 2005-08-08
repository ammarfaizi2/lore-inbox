Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVHHPXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVHHPXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbVHHPXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:23:10 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:4737 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750908AbVHHPXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:23:10 -0400
Message-ID: <42F778E2.2000602@gmail.com>
Date: Mon, 08 Aug 2005 17:23:14 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/video/sis/ macros for old kernels removal
References: <42F775F6.8090600@gmail.com>
In-Reply-To: <42F775F6.8090600@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):

> This patch removes some #ifs, which controls kernel version (2.4 or 
> like), so the code could be removed with the macros.
> linux/version.h inclusions also removed.

Sorry, this was bad idea. X includes some of these file, doesn't it?
