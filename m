Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWFCQg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWFCQg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 12:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWFCQg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 12:36:26 -0400
Received: from smtpout.mac.com ([17.250.248.172]:53722 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751316AbWFCQg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 12:36:26 -0400
In-Reply-To: <448134AD.7060502@gmail.com>
References: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <447CBEC5.1080602@gmail.com> <20060602083604.GA2480@localhost.localdomain> <20060602085832.GA25806@elf.ucw.cz> <Pine.LNX.4.63.0606021146320.4686@qynat.qvtvafvgr.pbz> <20060602220104.GA6931@elf.ucw.cz> <Pine.LNX.4.63.0606021256470.4686@qynat.qvtvafvgr.pbz> <4480C8D9.5080309@gmail.com> <20060603063251.GF6931@elf.ucw.cz> <448134AD.7060502@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A12E8656-AE17-43CA-B70E-350B19D78FA1@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, David Lang <dlang@digitalinsight.com>,
       Ondrej Zajicek <santiago@mail.cz>, Jon Smirl <jonsmirl@gmail.com>,
       Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sat, 3 Jun 2006 12:35:41 -0400
To: "Antonino A. Daplas" <adaplas@gmail.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 3, 2006, at 03:05:17, Antonino A. Daplas wrote:
> Pavel Machek wrote:
>> Well, you can only miss a message *you would not see anyway*.
>
> There are some things that one can see but not read, and still be  
> recognizable even if your console is scrolling by.

You would not even be able to recongnize it; we're talking about  
displaying text faster than the refresh rate, as pavel mentioned  
earlier:

On Sat, 3 Jun 2006, Pavel Machek wrote:
> I'm not talking about reading speed, I'm talking about displaying  
> speed. Once you display more than refresh rate times screen size...  
> you may as well cheat -- xterm-like. If xterm detects too much  
> stuff is being displayed, it simply stops displaying it, only  
> refreshing screen few times a second...

On the other hand, making the text console much more efficient would  
save a some CPU for *other* processes, say the one that's outputting  
text at such a high rate of speed, so it's probably worth it if it's  
not too hard.

Cheers,
Kyle Moffett

