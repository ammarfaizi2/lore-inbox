Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVLJHJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVLJHJe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVLJHJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:09:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5520 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964931AbVLJHJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:09:34 -0500
Date: Fri, 9 Dec 2005 23:09:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@brturbo.com.br
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org, js@linuxtv.org,
       linux-dvb-maintainer@linuxtv.org, mchehab@brturbo.com.br
Subject: Re: [PATCH 39/56] V4L/DVB (3099) Fixed device controls for em28xx
 on WinTV USB2 devices
Message-Id: <20051209230911.6d802e05.akpm@osdl.org>
In-Reply-To: <1134084178.7047.221.camel@localhost>
References: <1134084178.7047.221.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@brturbo.com.br wrote:
>
> +		int volume = MAX(msp->left, msp->right);

Please kill msp3400.c's MAX() and MIN().  Use max() and min() from kernel.h.

