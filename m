Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVGJDde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVGJDde (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 23:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVGJDde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 23:33:34 -0400
Received: from node-40240a4a.sjc.onnet.us.uu.net ([64.36.10.74]:24587 "EHLO
	sphinx.zankel.net") by vger.kernel.org with ESMTP id S261830AbVGJDde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 23:33:34 -0400
Message-ID: <42D0990D.8030701@zankel.net>
Date: Sat, 09 Jul 2005 20:42:05 -0700
From: Christian Zankel <chris@zankel.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050210)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: czankel@tensilica.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: arch xtensa does not compile
References: <42BD6557.9070102@ppp0.net> <42BD8622.8060506@zankel.net> <42C80B34.80007@ppp0.net>
In-Reply-To: <42C80B34.80007@ppp0.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> I guess I'm using the wrong binutils version (2.15.94.0.2.2). Which is the
> recommended gcc/binutils pair which is supposed to compile the kernel?

Bob Wilson made some changes to binutils last week to address this 
problem but he only submitted it to the latest binutils version.

With the latest gcc+binutils toolchain, the kernel compiles for me.
Note, however, that I just submitted a patch that is not in Linus' tree, 
yet.

gcc version 3.4.5 20050707 (prerelease)
GNU ld version 2.16.91 20050707

Thanks,
Chris
