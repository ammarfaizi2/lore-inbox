Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbUKQI0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbUKQI0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUKQI0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:26:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:9934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262230AbUKQI0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:26:51 -0500
Date: Wed, 17 Nov 2004 00:26:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] i386: always enable REGPARM
Message-Id: <20041117002620.5f03f5a5.akpm@osdl.org>
In-Reply-To: <20041117043223.GF4943@stusta.de>
References: <20041117043223.GF4943@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Is there still a known reason to disable CONFIG_REGPARM on i386 with
>  gcc 3?

Well it lets us turn it off again if we suspect a regparm-related bug. 
That's happened a couple of times.
