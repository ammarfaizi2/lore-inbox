Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVDOTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVDOTUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVDOTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:20:04 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:12248 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261931AbVDOTT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:19:56 -0400
Message-ID: <426013DD.6050905@tomt.net>
Date: Fri, 15 Apr 2005 21:19:57 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Allison <fireflyblue@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Rootkits
References: <17d79880504151115744c47bd@mail.gmail.com> <20050415183738.GR17865@csclub.uwaterloo.ca>
In-Reply-To: <20050415183738.GR17865@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> Well you could build a monilithic kernel with module loading turned off
> entirely, but that doesn't prevent replacing libc which most programs
> use to make those system calls.

As pointed out elsewhere, modules is not the only way to load kernel 
code live. Modules is just a cleaner interface for it. Rootkits capable 
of loading their kernel code without involving the module system has 
existed for ages.

> Could make the filesystem readonly,
> that would prevent writing a module to load into the kernel, and
> replacing libc as long as you make it imposible to remount the
> filesystem at all.

Don't hold your breath - code can be inserted without involving actual 
files. It just makes things less persistent.

-- 
Cheers,
André Tomt
