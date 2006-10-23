Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWJWUak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWJWUak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWJWUak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:30:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:63904 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751423AbWJWUaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:30:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=npWpOFPWG+Ey+aXpAolMj3UFpL2BNbY5/sxuDH4S/iIap/mBscwscJjMEVW19/bMGqjiB5Jd9iWFeqUb/WBNhksGLV5/dVqyv0UXoFeWH6RWsY1hTQrRtx9OWuj360586SSASG8j+LvUhftMjPn5EGuhzXp6sZVK0WxRDMOO+es=
Message-ID: <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
Date: Mon, 23 Oct 2006 22:30:36 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
	 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
	 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
	 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
	 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
	 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
	 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 17/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
[...]
> > and just run the resulting kernel version for a day or two. If an hour
> > wasn't really good enough, it's not as repeatable as we'd have wished, but
> > even if it takes a few days to narrow it down by just two bisections or
> > so, it will cut things down from ten thousand commits to "just" 2500..
> >
> Ok, sure. I'll do a days run of 2.6.19-rc2 first, just to see if it's
> been fixed in the mean time. If it's still there I'll try to get a
> sysrq+t and post that, then I'll restart bisection and give each
> kernel a full 24hrs of testing before concluding it is good.
>
> I'll report back as soon as I have some results.
>
Ok, I've been unable to do any testing for a few days, but today I had
some spare time and set my box to run my test script while doing some
other work. It was running latest git at the time of 2.6.19-rc2 + a
day or two and it locked up after ~20min.
So we are not so lucky that the problem has been fixed by some of the
patches that have gone in recently :-(

Since there was nothing in the system logs and the box was completely
frozen (not even sysrq worked) I goess I'll have to try and restart
the bisection.

Just wanted to report the little data I had. I'll be back with more
(hopefully soon).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
