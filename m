Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132622AbRDBF1t>; Mon, 2 Apr 2001 01:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDBF1j>; Mon, 2 Apr 2001 01:27:39 -0400
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:54538 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S132622AbRDBF1Y>; Mon, 2 Apr 2001 01:27:24 -0400
Subject: Re: bug database braindump from the kernel summit
From: Richard Russon <kernel@flatcap.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com>
In-Reply-To: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10+cvs.2001.04.01.08.06 (Preview Release)
Date: 02 Apr 2001 06:26:45 +0100
Message-Id: <986189206.789.0.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Apr 2001 18:21:29 -0500, Jeff Garzik wrote:
> Let's hope it's not a flamewar, but here goes :)
> 
> We -need- .config, but /proc/config seems like pure bloat.

Don't ask me for sample code, but...

The init code for many drivers is freed up after it's used.
Could we apply the same technique and compile in .config,
then printk the entire lot (boot option) and free up the
space afterwards?

FlatCap (Richard Russon)
kernel@flatcap.org

