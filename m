Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWIDSfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWIDSfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 14:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWIDSfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 14:35:44 -0400
Received: from mail.linicks.net ([217.204.244.146]:57361 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S964974AbWIDSfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 14:35:43 -0400
From: Nick Warne <nick@linicks.net>
To: "Bas Bloemsaat" <bas.bloemsaat@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Vicam driver, device
Date: Mon, 4 Sep 2006 19:35:37 +0100
User-Agent: KMail/1.9.4
References: <7c4668e50609021101j2b8c561er94d41ca95aca2b1b@mail.gmail.com> <7c3341450609030930h3b5d7edah5dc52049b9760004@mail.gmail.com> <7c4668e50609041128j4e382815me92cdbabb53d662d@mail.gmail.com>
In-Reply-To: <7c4668e50609041128j4e382815me92cdbabb53d662d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609041935.37858.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 19:28, Bas Bloemsaat wrote:
> Yes, but not an oops as you describe. I get the following in the
> syslog when I modprobe it:
> kernel: videodev: "ViCam-based USB Camera" has no release callback.
> Please fix your driver for proper sysfs support, see
> http://lwn.net/Articles/36850/

No sorry, I worded it all wrong.  I meant on modprobe.  I then attempted to 
fix the code, which produced kernel oops, so it was my bad code that caused 
it - it needs someone that knows what they are doing ;-)

> When rmmodding, the only message I see is: "kernel: usbcore:
> deregistering driver vicam", which seems normal.

After my attempted fixes, this is when my kernel crashed.

> I didn't plan on using the webcam, I just couldn't stand that it
> didn't work while a driver was supposed to be available, and now it
> works.

I don't use mine now, but it would be nice to get this code brought up to 
date.

Nick
-- 
Every program has two purposes:
one for which it was written and another for which it wasn't.
