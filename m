Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVLJHGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVLJHGZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVLJHGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:06:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964932AbVLJHGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:06:24 -0500
Date: Fri, 9 Dec 2005 23:05:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@brturbo.com.br
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org, js@linuxtv.org,
       linux-dvb-maintainer@linuxtv.org, mchehab@brturbo.com.br
Subject: Re: [PATCH 33/56] V4L/DVB (3081) added offset parameter for
 adjusting tuner offset by hand
Message-Id: <20051209230559.4d46e7b0.akpm@osdl.org>
In-Reply-To: <1134084178.7047.209.camel@localhost>
References: <1134084178.7047.209.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@brturbo.com.br wrote:
>
> +static int offset = 0;
>  

No need to initialise this to zero.  We avoid doing that because the
initialised variable takes up space in the kernel image.
