Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbTF1XQF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTF1XQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:16:05 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:12980 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265488AbTF1XP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:15:57 -0400
Date: Sat, 28 Jun 2003 19:30:13 -0400
From: Tom Vier <tmv@comcast.net>
Subject: Re: /dev/random broken?
In-reply-to: <3EFE2231.2050707@libero.it>
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20030628233013.GA12370@zero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <3EFE2231.2050707@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 01:18:09AM +0200, Luca T. wrote:
>  dd if=/dev/random of=./xxx bs=1024 count=100
> it will just sit there and stare at me until i move the mouse... and 
> Is this a bug? If yes... do you have any idea that would help me fix it?

no, use /dev/urandom. man urandom. read drivers/char/random.c.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
