Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVFRRGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVFRRGx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 13:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVFRRGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 13:06:53 -0400
Received: from mail.linicks.net ([217.204.244.146]:21766 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262157AbVFRRGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 13:06:51 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Date: Sat, 18 Jun 2005 18:06:49 +0100
User-Agent: KMail/1.8.1
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com>
In-Reply-To: <42B45173.6060209@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181806.49627.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 17:53, Jeff Garzik wrote:
> Nick Warne wrote:
> > New 2.6.12 build hangs at initialising udev dynamic device directory on
> > boot.
>
> Did you try simply waiting a while?
>
> udev took a long time to initialize (30-40 seconds) for me, then
> everything worked and the machine booted just fine.
>
> I've seen this on both new and old udev.  Some patience will fix things :)

Yes, I waited a while first time.  No drive activity, no nothing.  Keyboard 
was still awake though, so it wasn't a 'crash' as such. The boot just stopped 
there twiddling it's thumbs...

Installing the latest udev though makes the machine boot so fast I can't see 
the 'initialising udev devices' message unless I scroll back to see in 
console.  I thought at first I broke it, and udev wasn't working at all now 
and was being ignored, but it is working just fine :-)

But remember, what got me was it boots fine on 2.6.11.12, insomuch I never 
really saw the udev message away and never had to investigate it before.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
