Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWB1VNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWB1VNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWB1VNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:13:35 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:48761 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932625AbWB1VNe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:13:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tLyCyFtHwQi3HLT+Ti9Y8WWkEgg653SNPhFEQGm8BDC2Dv5HnzLaiO9tniMAXC6fKcnFvbeXPIzsW1YT4doOeDAmSJxS7oVRGMTT/JWD8O/1pgo123uLgVrTQSEohvV18NFtlkSoBVHT/C1Cux7qbTrxy6ECFsKWDeMRbfVnXyU=
Message-ID: <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
Date: Tue, 28 Feb 2006 22:13:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060228042439.43e6ef41.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060228042439.43e6ef41.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm1/
>

Ok, something is definately broken in this kernel.

If I launch Eclipse (http://www.eclipse.org/) while running a
2.6.16-rc5-mm1 kernel it loads for a second or two and then the box
just locks up solid.

I then went back to my previous kernel, 2.6.16-rc4-mm2, and there's no
problem what-so-ever when running that kernel (everything else
identical) - eclipse loads and runs just fine.

Since I'm in X when the lockup happens and I don't have enough time
from clicking the eclipse icon to the box locks up to make a switch to
a text console I don't know if an Oops or similar is dumped to the
console (there's nothing in the locks after a reboot)  :-(

Unfortunately I don't have a second box to use with serial console or
netconsole, but I'll see if I can somehow get some console messages -
perhaps by slowing down the eclipse load process somehow... I'll see
what I can do and report back when I have more into.
If all else fails and noone on LKML can suggest patches to try and
revert or similar I guess I'll eventually do a git bisect, but I'd
rather try other things first...

The version of Eclipse I'm running is 3.1.2

The problem is completely reproducible (well, at least it occoured 6
times in a row and that's how many times I tried).

Sorry for the lack of detail, but I thought I'd better report the
issue at once and then follow up with details later :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
