Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284519AbRLIVzP>; Sun, 9 Dec 2001 16:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284518AbRLIVzF>; Sun, 9 Dec 2001 16:55:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47888 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284491AbRLIVys>; Sun, 9 Dec 2001 16:54:48 -0500
Message-ID: <3C13DDF5.2050303@zytor.com>
Date: Sun, 09 Dec 2001 13:56:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: torvalds@transmeta.com, marcelo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux/i386 boot protocol version 2.03
In-Reply-To: <200112090922.BAA11252@tazenda.transmeta.com> <m17krww8ky.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 2) If we use units of kilobytes instead of bytes for this we don't
>    loose any precision and gain the ability to put a ramdisk in high
>    memory without bumping the protocol version.

Thought about it some more, and then realized we would have to do a lot 
more overhaul of the boot protocol than this to support initrd in highmem 
... and we'd still not be able to actually use it on any real 
configuration.  Thanks, but no thanks.

	-hpa

