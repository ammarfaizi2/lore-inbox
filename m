Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272924AbTHPOCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272927AbTHPOCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:02:45 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:44762
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272924AbTHPOCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:02:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Voluspa <lista1@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O16.2int
Date: Sun, 17 Aug 2003 00:09:06 +1000
User-Agent: KMail/1.5.3
References: <20030816130735.3ec67ac9.lista1@telia.com>
In-Reply-To: <20030816130735.3ec67ac9.lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308170009.06461.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003 21:07, Voluspa wrote:
> On 2003-08-16 8:59:48 Con Kolivas wrote:
> > Much simpler
>
> For a coder, perhaps. This user however is facing what feels like a
> fundamental flaw. The doubling of boot time was fixed, but game-test is
> pretty much as it was in pure O16 (impossible) and Blender is equally
> bad - now even the mouse pointer vanishes, becomes invisible, during the
> 10+ second pauses. And it is with Blender as only app running. Didn't
> dare to start xmms...

Nice. 

Funny you should mention xmms in the same sentence since that's an app that 
works fine. I was under no illusion that O16s were going to make these apps 
perform well.  Now you have to clarify what you mean by game test as being 
impossible. I assume you mean wine based games? The only game I own is 
neverwinternights and that performs beautifully. You have to tell me about 
this blender app? I'm unable to fully reproduce these problems here as the 
only thing exhibiting starvation is a mozilla plugin that is busy on wait 
using the libgdk(something) library, and it is usable without starvation 
albeit at sucky performance. If you can profile blender sucking it would be 
helpful. 

> I'll keep running the 2.6.0-test3 ---> O16.2int though. Might pick up
> other cases of regression in lighter usage.

It's not a matter of light versus heavy, it's only select applications. Try 
running your machine at absurd loads (without hitting swap) with apps that 
don't exhibit it. 

Since these are the last thing in my gunsights for the interactivity 
development I'd appreciate as much info as anybody has on what happens when 
they suck, and if profiling can find a common link. Since I own none of the 
apps that do this I can only try to fix them with your help. If someone is 
available for frequent small patch testing that would also be helpful as that 
helped the other interactivity development, so please email me directly.

Con

