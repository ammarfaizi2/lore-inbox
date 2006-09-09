Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWIINoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWIINoW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 09:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWIINoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 09:44:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12004 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932179AbWIINoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 09:44:21 -0400
Message-ID: <4502C52F.9080900@garzik.org>
Date: Sat, 09 Sep 2006 09:44:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] linux/magic.h for magic numbers
References: <20060909110245.GA9617@havoc.gtf.org> <Pine.LNX.4.63.0609091453200.29522@alpha.polcom.net> <4502C086.2080302@garzik.org> <20060909133334.GB17085@uranus.ravnborg.org>
In-Reply-To: <20060909133334.GB17085@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> But do we want one common set of magic numbers or do we try to divide it
> up per subssystem. The lattter approach are used for many other purposes
> so why not for magics too?
> Or in other word magic.h => fs_magic.h

It's a fair question.  I would say, let need dictate the rename.

linux/poison.h covers many subsystems.  And even across the entire 
kernel, we don't often add magic numbers...

	Jeff


