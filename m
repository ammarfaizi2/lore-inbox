Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTIXQia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbTIXQi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:38:29 -0400
Received: from lpbproductions.com ([68.98.208.147]:25018 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S261488AbTIXQi2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:38:28 -0400
From: Matt Heler <lkml@lpbproductions.com>
To: Scott Robert Ladd <coyote@coyotegulch.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minimizing the Kernel
Date: Wed, 24 Sep 2003 09:39:01 -0700
User-Agent: KMail/1.5.9
References: <3F71C712.9070503@coyotegulch.com>
In-Reply-To: <3F71C712.9070503@coyotegulch.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309240939.02316.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well for starters dont use gcc 3 or above.. code size has increased 
dramatically with thoose versions. sure they give you more optimization , but 
if your looking for a small kernel use anything below 3..

Matt H.

On Wednesday 24 September 2003 09:32 am, Scott Robert Ladd wrote:
> I want to created the smallest, fastest kernel that supports all the
> necessary features of a given system.
>
> Obviously, the answer is very system dependent, requiring a keen
> knowledge of the relationships between hardware and Linux components.
>
> Unless I'm missing something (always a possibility), the kernel
> configurations do not provide a clear idea of component size. In other
> words, if I include "burfulgunk port support" in my kernel build, I'd
> like to have a rough idea of the component's size. I might not need to
> support the "burfulgunk", especially if it's a large component (for,
> say, a legacy port.)
>
> I'm well aware that code sizes differ between platforms; I'm looking for
> general information, as a guideline to generating a small kernel.
