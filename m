Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281004AbRKGVO5>; Wed, 7 Nov 2001 16:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280994AbRKGVNr>; Wed, 7 Nov 2001 16:13:47 -0500
Received: from dispatch.lakeheadu.ca ([216.211.0.8]:15375 "HELO
	dispatch.lakeheadu.ca") by vger.kernel.org with SMTP
	id <S280991AbRKGVNQ>; Wed, 7 Nov 2001 16:13:16 -0500
Message-ID: <3BE98EB8.6000802@mail.myrealbox.com>
Date: Wed, 07 Nov 2001 14:42:48 -0500
From: "Daniel R. Warner" <drwarner@mail.myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.5) Gecko/20011019
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Yet another design for /proc. Or actually /kernel.
In-Reply-To: <slrn9uj1nf.5lj.spamtrap@dexter.hensema.xs4all.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema wrote:

> Here's my go at a new design for /proc. I designed it from a userland
> point of view and tried not to drown myself into details.

<snip>

> - Multiple values per file when needed
> 	A file is a two dimensional array: it has lines and every line
> 	can consist of multiple fields.
> 	A good example of this is the current /proc/mounts.
> 	This can be parsed very easily in all languages.


> 	No need for single-value files, that's oversimplification.
<snip>


This is fine for reading, but it makes it harder for humans to change 
values in /proc - eg, echo 0 > /proc/sys/net/ipv4/tcp_ecn

-D


