Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVBJTZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVBJTZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVBJTZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:25:29 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:6477 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261377AbVBJTZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:25:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=O8k/GR5UCrFE+/8ggmaq463ry11qDSB+XQujlm6lDgKQxrM8T8Tt/YUBHUoq9KOWVqxiki9xC9+onwvaetKilPNuFo90HGs3kzyEU3CwoCPzZWn9qE3Sj2lj6LPEqmTnTstKhOPDhYgRkxtQy8InQbK+cKMMs8lS0Su+3KWXuy8=
Message-ID: <d120d500050210112417751633@mail.gmail.com>
Date: Thu, 10 Feb 2005 14:24:58 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] sonypi driver update
In-Reply-To: <20050210154420.GE3493@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050210154420.GE3493@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 16:44:21 +0100, Stelian Pop <stelian@popies.net> wrote:
> Hi,
> 
> Over the last few weeks I've collected a few patches in my tree
> coming from others and it's time to merge them upstream:
> 
>        1/5: sonypi: replace schedule_timeout() with msleep()
>        2/5: sonypi: add another HELP button event
>        3/5: sonypi: use MISC_DYNAMIC_MINOR in miscdevice.minor assignment.
>        4/5: sonypi: fold the contents of sonypi.h into sonypi.c
>        5/5: sonypi: add fan and temperature status/control

Any chance that last one could be done via sysfs attributes instead of
new IOCTLs? This way you can control fan from the command line.

-- 
Dmitry
