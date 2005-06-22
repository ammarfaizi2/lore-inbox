Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVFVSMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVFVSMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFVSMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:12:24 -0400
Received: from mail.linicks.net ([217.204.244.146]:15379 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261690AbVFVSKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:10:15 -0400
From: Nick Warne <nick@linicks.net>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Two agpgart probes at boot.
Date: Wed, 22 Jun 2005 19:10:09 +0100
User-Agent: KMail/1.8.1
References: <200506171943.40592.nick@linicks.net> <20050620224039.GA3990@redhat.com>
In-Reply-To: <20050620224039.GA3990@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506221910.09505.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 23:40, Dave Jones wrote:

> These messages aren't probing messages per se. They happen when something
> (typically X) opens /dev/agpgart and sets up dri. It'll get logged
> every time that X gets restarted.  That there are two of them with the
> same datestamp is odd though. For some reason your X did this twice.

Ok, thanks for the info on what is going on.  I have just spent a few minutes 
looking at all the logs and configs, but can see nothing untoward.

I don't load the DRI module in xorg.conf, btw.

It doesn't harm anything, so I will stumble on the reason why one day when 
doing something else, I expect.  It maybe a nVidia thing...

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
