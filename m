Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275253AbTHSAVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275255AbTHSAVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:21:32 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:36231
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275253AbTHSAVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:21:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Wes Janzen <superchkn@sbcglobal.net>
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
Date: Tue, 19 Aug 2003 10:28:11 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030817003128.04855aed.voluspa@comhem.se> <200308172336.42593.kernel@kolivas.org> <3F416BD4.3040302@sbcglobal.net>
In-Reply-To: <3F416BD4.3040302@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308191028.11109.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 10:14, Wes Janzen wrote:
> I think this problem is exacerbated when another app is competing for
> the processor.  The machine just pauses unless I'm also doing something
> else, in this case compiling XINE.  Once something is competing, it
> looks like X takes an extraordinarily long time to come back into the
> running queue.

Yes that is correct behaviour and to be expected.

> Is there a way to figure out when a process is spinning on a wait and

That's the trick isn't it? No there isn't or else I'd fix it in a jiffy. If 
someone can think of a way I'd love to know.

> exponentially decrease it's bonus if they are consecutive?  I should
> probably read through the source and some of these posts before I make
> suggestions though, because I don't currently know much about how all
> that works.

If you get a chance could you try the prerelease O17 patch against O16.3 in 
http://kernel.kolivas.org/2.5/experimental to see if that helps? It's purely 
an anti-starvation patch.

Thanks for comments.

Cheers,
Con

