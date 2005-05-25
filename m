Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVEYIfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVEYIfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 04:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVEYIfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 04:35:45 -0400
Received: from main.gmane.org ([80.91.229.2]:8678 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261409AbVEYIfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 04:35:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: RT patch acceptance
Date: Wed, 25 May 2005 10:29:43 +0200
Message-ID: <1sqzfpcvfd64k.19ompsenhoq7d.dlg@40tude.net>
References: <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com> <1116978244.19926.41.camel@dhcp153.mvista.com> <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dipmat.unict.it
User-Agent: 40tude_Dialog/2.0.15.1
Posted-And-Mailed: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2005 08:33:06 +0200, Ingo Molnar wrote:

> i agree in theory, but interestingly, people who use the -RT branch do 
> report a smoother desktop experience. While it might also be a 
> psychological effect, under -RT an interactive X process has the same 
> kind of latency properties as if all of the mouse pointer input and 
> rendering was done in the kernel (like some other desktop OSs do).

The only way to actually know if it really makes a difference or not
would be to run a double-blind test, with people not knowing if
they're running a RT kernel or not, and then reporting their
experience re. desktop smoothness. But I doubt such a test could
actually be taken into consideration, unless distributions start
shipping with different kernels without the user knowing, and then ask
about how it feels ...

This all being said, esp. concerning the next point you rise

> so in terms of mouse pointer 'smoothness', it might very well be 
> possible for humans to detect a couple of msec delays visually - even 
> though they are unable to notice those delays directly. (Isnt there some 
> existing research on this?)

IIRC, there have been (I'm not sure if there still are) some issues
with IRQs being lost on the input devices, missing keys, missing
events or misbehaving of mice and similar ... would these problems
(and the underlying issues in the codepaths) be more easy or harder to
happen and to trace if they happened?

-- 
Giuseppe "Oblomov" Bilotta

"They that can give up essential liberty to obtain
a little temporary safety deserve neither liberty
nor safety." Benjamin Franklin

