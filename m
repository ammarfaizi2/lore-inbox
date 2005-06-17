Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVFQILc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVFQILc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 04:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVFQILc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 04:11:32 -0400
Received: from mail2.designassembly.de ([217.11.62.46]:55765 "EHLO
	mail2.designassembly.de") by vger.kernel.org with ESMTP
	id S261905AbVFQILa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 04:11:30 -0400
Message-ID: <42B285B0.7090803@designassembly.de>
Date: Fri, 17 Jun 2005 10:11:28 +0200
From: Michael Heyse <mhk@designassembly.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050412)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain> <42B14415.5060105@designassembly.de> <Pine.LNX.4.63.0506160523190.6459@p34>
In-Reply-To: <Pine.LNX.4.63.0506160523190.6459@p34>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Alan followed up with me but we did not reach any conclusion as to what
> was causing it to crash.  The main way I got it to crash was dd
> if=/dev/hde (root drive) of=/nfs/file.img bs=1M, I have not had any
> issues as far as copying files and such.  For you, is it on a particular
> box or boxes, have you tried copying the other direction?  I use NFS
> over UDP btw (v3).

Sadly I had to discover that those crashes are not really NFS related, but when I'm using NFS they
are triggered much more often than otherwise. The machine ran stable for almost 2 days now without
NFS but then still hung.

Thank you for your time!
Michael
