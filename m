Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbULUX1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbULUX1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbULUX1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:27:12 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:39441 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP id S261895AbULUX1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:27:00 -0500
Message-ID: <41C8B128.7010201@xs4all.nl>
Date: Wed, 22 Dec 2004 00:26:32 +0100
From: Pjotr Kourzanov <peter.kourzanov@xs4all.nl>
Organization: Appose.org
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Sturtevant <sturtx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fork/clone external to a process?
References: <7d92433304122107491b8b624a@mail.gmail.com>
In-Reply-To: <7d92433304122107491b8b624a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Sturtevant wrote:
> Hi,
> 
> Is there any clean way to fork a process from outside the process itself?
> 
> I'm running a commercial application that I only have a binary copy
> of.  All the usual Posix fork stuff only works from inside the running
> process.

   Have you tried playing with LD_PRELOAD (libc.so hack)?

> 
> Is there any reason it's not possible to do so?  Obviously threading
> and file desciptors open a whole can of worms, but in the base case,
> is it possible?
> 
> Thanks in advance, and sorry if it's a stupid question.
> 
> Dan Sturtevant
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

