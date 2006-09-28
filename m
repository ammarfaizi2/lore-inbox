Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965307AbWI1K4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965307AbWI1K4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 06:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbWI1K4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 06:56:13 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:7569 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S965307AbWI1K4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 06:56:12 -0400
In-Reply-To: <20060928102100.GA27424@uranus.ravnborg.org>
References: <20060928060224.GA16290@aepfle.de> <Pine.LNX.4.61.0609281032420.21498@yvahk01.tjqt.qr> <20060928102100.GA27424@uranus.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <49C331A3-512C-4CFF-8226-A6540166815F@kernel.crashing.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Olaf Hering <olaf@aepfle.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add XARGS to toplevel Makefile
Date: Thu, 28 Sep 2006 12:55:00 +0200
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> run xargs with --no-run-if-empty to avoid random failures:
>>
>> How about the short option, -r?
> Is it more portable - otherwise the more descriptive option is  
> preferred.

Neither is portable, and -r tends to hide real bugs; please use
something else instead, like making the relevant makefile targets
non-fatal (lots of-em already are).


Segher

