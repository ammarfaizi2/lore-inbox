Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSLQSmX>; Tue, 17 Dec 2002 13:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSLQSmX>; Tue, 17 Dec 2002 13:42:23 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:51636
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265475AbSLQSmV>; Tue, 17 Dec 2002 13:42:21 -0500
Message-ID: <3DFF717C.90006@redhat.com>
Date: Tue, 17 Dec 2002 10:48:28 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212170858510.2702-100000@home.transmeta.com> 	<3DFF6501.3080106@redhat.com> <1040153030.20804.8.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1040153030.20804.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Is there any reason you can't just keep the linker out of the entire
> mess by generating
> 
> 	.byte whatever
> 	.dword 0xFFFF0000
> 
> instead of call ?

There is no such instruction.  Unless you know about some secret
undocumented opcode...

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

