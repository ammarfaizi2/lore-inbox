Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283695AbRK3PoP>; Fri, 30 Nov 2001 10:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283685AbRK3PoG>; Fri, 30 Nov 2001 10:44:06 -0500
Received: from [195.63.194.11] ([195.63.194.11]:42514 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S283688AbRK3Pnx>; Fri, 30 Nov 2001 10:43:53 -0500
Message-ID: <3C07A6E6.45A4AC61@evision-ventures.com>
Date: Fri, 30 Nov 2001 16:33:58 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Simon Turvey <turveysp@ntlworld.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Generating a function call trace
In-Reply-To: <001501c179b1$870db7c0$140ba8c0@mistral>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Turvey wrote:
> 
> Is it possible to arbitrarily generate (in a module say) a function call
> trace?
> 

Just insert the dereference of a NULL pointer where you wan't to have
it.
The oops gives you what you wan't....
Or better attach the gdb to /proc/kmem (you will have to compile the
kernel with
debugging on in front of this action) and have fun.
