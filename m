Return-Path: <linux-kernel-owner+w=401wt.eu-S1752037AbXARSsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbXARSsx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 13:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbXARSsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 13:48:53 -0500
Received: from terminus.zytor.com ([192.83.249.54]:51261 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbXARSsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 13:48:52 -0500
Message-ID: <45AFC105.7050109@zytor.com>
Date: Thu, 18 Jan 2007 10:48:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Tomasz Chmielewski <mangoo@wpkg.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <45AE1D65.4010804@wpkg.org> <Pine.LNX.4.61.0701171435060.18562@yvahk01.tjqt.qr> <45AE2E25.50309@wpkg.org> <45AE8818.1050803@zytor.com> <45AF4CF9.1070801@wpkg.org> <45AF502F.9010009@zytor.com> <45AF5E8E.9020607@wpkg.org>
In-Reply-To: <45AF5E8E.9020607@wpkg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Chmielewski wrote:
> 
> I managed to compile a "Testing" 1.4.31 version (in fact, version 1.4 
> didn't compile because I didn't have a "linux" link pointing to kernel 
> sources; version 1.4.31 tells that it's missing - so both versions 
> compile fine).
> 

At this point, 1.4.31 is probably what you should be using.

> The problem is... I'm not sure how to start with it. The package doesn't 
> have much documentation (other than "read the source"), does it?
> 
> On the other hand, I see it comes with a couple of useful tools, like sh 
> (dash)... They are also pretty small, so everything should fit into 300 
> kB (dash=70kB, kinit=70kB, mount=12kB).

With kinit you don't even need dash/mount... kinit is a monolithic 
binary for everything.

In other words, you'd typically use *either* dash+mount, *or* kinit...

	-hpa
