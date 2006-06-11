Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbWFKB1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbWFKB1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 21:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWFKB1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 21:27:06 -0400
Received: from quechua.inka.de ([193.197.184.2]:40676 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1161063AbWFKB1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 21:27:05 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <448B61F9.4060507@gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FpEjH-0005XX-00@calista.eckenfels.net>
Date: Sun, 11 Jun 2006 03:27:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas <adaplas@gmail.com> wrote:
>> How can I change where printk are going at run-time? I didn't know you
>> could do that.
> 
> I really don't know.  Maybe we have some kind of entry in /proc somewhere?

Console redirection can be asked for with the TIOCCONS ioctl(), this is for
example used by "xterm -C". I am not sure how to manipulate the system list
of console destinations.

Gruss
Bernd
