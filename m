Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVKKXT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVKKXT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVKKXT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:19:57 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:59432 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751301AbVKKXT5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:19:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tcVWxKOG8p/dOF20Y/5GuSD0UrgtF2gavUv/QpErsqoKWFrDxx0Vr79ccHcgXi9nxQJ/yIqR11coHNbmcKcuH6yHHRHmfFiC9/VX929maezyyoankSvMdky0QLZLgeVjHYuku3FBFDRlxFEL8yLcACJe1YwqZSCLjWLEdQCWQN8=
Message-ID: <9a8748490511111519h28c61279q2a1616a869e72be6@mail.gmail.com>
Date: Sat, 12 Nov 2005 00:19:56 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Miro Dietiker, MD Systems" <info@md-systems.ch>
Subject: Re: Patches for Kernel 2.6.14 on kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <012b01c5e710$b74e4460$4001a8c0@MDSYSPORT>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <012b01c5e710$b74e4460$4001a8c0@MDSYSPORT>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/05, Miro Dietiker, MD Systems <info@md-systems.ch> wrote:
> Hi!
>
> As of the kernel.org/pub/linux/kernel/README all patches need to be
> applied (bigger than the
> current local version)
>
> For the current 2.6.14.2 this seems not to be true (The patch 2.6.14.1
> seems to be included in
> 2.6.14.2)
>
The 2.6.14.2 patch is to be applied against 2.6.14 - the -stable
patches are not incremental.

> Is this a "new" undocumented general behaviour such as e.g. patches
> always based on the
> latest 3-Number version or is this a small mistake?
>
Not new, no mistake.

http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt

Read the "The 2.6.x kernels" and the "The 2.6.x.y kernels" sections.


> In any case: One of the described sources need to be corrected, I think.
>
I think the README should refer people to
Documentation/applying-patches.txt for more details. I'll submit a
patch in a little while to do that.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
