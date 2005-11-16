Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbVKPT0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVKPT0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVKPT0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:26:36 -0500
Received: from mail.linicks.net ([217.204.244.146]:6341 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1030447AbVKPT0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:26:36 -0500
From: Nick Warne <nick@linicks.net>
To: Dave Jones <davej@redhat.com>
Subject: Re: Two agpgart probes at boot.
Date: Wed, 16 Nov 2005 19:26:30 +0000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200506171943.40592.nick@linicks.net> <20050620224039.GA3990@redhat.com> <200506221910.09505.nick@linicks.net>
In-Reply-To: <200506221910.09505.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511161926.30996.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 19:10, Nick Warne wrote:
> On Monday 20 June 2005 23:40, Dave Jones wrote:
> > These messages aren't probing messages per se. They happen when something
> > (typically X) opens /dev/agpgart and sets up dri. It'll get logged
> > every time that X gets restarted.  That there are two of them with the
> > same datestamp is odd though. For some reason your X did this twice.
>
> Ok, thanks for the info on what is going on.  I have just spent a few
> minutes looking at all the logs and configs, but can see nothing untoward.
>
> I don't load the DRI module in xorg.conf, btw.
>
> It doesn't harm anything, so I will stumble on the reason why one day when
> doing something else, I expect.  It maybe a nVidia thing...

Well, after all this time, it is a nVidia thing:

http://www.nvnews.net/vbulletin/showthread.php?t=59748

Hopefully google bot will index this and anybody else will find the answer.

Give nVidia their binary due though - at least they have bods on the forum to 
answer.

Nick
-- 
http://sourceforge.net/projects/quake2plus/

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

