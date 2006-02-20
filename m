Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWBTVVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWBTVVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWBTVVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:21:50 -0500
Received: from mail.linicks.net ([217.204.244.146]:17329 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750730AbWBTVVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:21:49 -0500
From: Nick Warne <nick@linicks.net>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: i386 AT keyboard LED question.
Date: Mon, 20 Feb 2006 21:21:43 +0000
User-Agent: KMail/1.9.1
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200602202003.26642.nick@linicks.net> <200602202051.51882.nick@linicks.net> <Pine.LNX.4.61.0602201608420.1577@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602201608420.1577@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202121.43436.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 20:57, Vojtech Pavlik wrote:

> The 'setleds' command in boot.local might be the fix you're looking for.

On Monday 20 February 2006 21:12, linux-os (Dick Johnson) wrote:
>
> In .. /etc/rc.d/rc.local
>  	/usr/bin/setleds -num /dev/tty0 (or whatever)

I must have made the dork post of the month - sorry for the noise.

setleds +num

is indeed what I needed in rc.local.

Still, at least I learnt a lot about initialising keyboard by reading the 
code.

Thank you!

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
