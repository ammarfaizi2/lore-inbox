Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276612AbRJUTBy>; Sun, 21 Oct 2001 15:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276628AbRJUTBe>; Sun, 21 Oct 2001 15:01:34 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:3205 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276622AbRJUTB2>; Sun, 21 Oct 2001 15:01:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: "Malcolm H. Teas" <mhteas@btech.com>
Subject: Re: The new X-Kernel !
Date: Sun, 21 Oct 2001 21:04:27 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya> <15vI4j-1Z1VtgC@fmrl02.sul.t-online.com> <3BD2F350.5000107@btech.com>
In-Reply-To: <3BD2F350.5000107@btech.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15vNqy-0CpFRIC@fmrl00.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 18:09, you wrote:
> But what graphics resources does the LPP require?  If it's more restricted
> than the current Linux boot process it affects server-oriented machines
> that aren't running X or graphics, that just serve resources on the net.
> I'd not like to see the minimum bar for hardware compatibility raised
> without very good cause.  Boot time messages aren't a good cause for me.
> YMMV.
> My feeling: At best it should be an option only, and default to no LPP.

Of couse as an option. I don't say that it's a good idea for servers, but I 
heard several times that people are "confused" by Linux's boot messages, and 
people consider it as less "friendly" than other OSes because of the boot 
messages that they don't understand anyway. So it may be a good idea for 
desktop machines and inexperienced users.

Currently it needs a VESA-framebuffer, and if this is not available it could 
fall back to text mode. I'm not sure what the current patch does in this 
situation though. 

bye...

