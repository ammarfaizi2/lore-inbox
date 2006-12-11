Return-Path: <linux-kernel-owner+w=401wt.eu-S1762851AbWLKLxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762851AbWLKLxq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 06:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762852AbWLKLxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 06:53:46 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:7858 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762851AbWLKLxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 06:53:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V4+ONyiTiwmIPi8KAoGOAitSWrGf9eOplxxfgs5/5s25GSgS+r5qv40ZU2r2RSv3e/cDpLBEEITNteCN+M1uxcBnnl13evhHPG5BhhqjDQwQo5X7hshzXrZA9v+ESpuBBgZALjCE1Zi/AI/qMX4TUo1tqGuorgiyO2wyQ3EQR0k=
Message-ID: <9a8748490612110353u6709690bwea42955f2162c4a7@mail.gmail.com>
Date: Mon, 11 Dec 2006 12:53:45 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Keir Fraser" <keir@xensource.com>
Subject: Re: [Xen-devel] Lots of "swapper: page allocation failure" and other memory related messages - 2.6.16-xen0
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com
In-Reply-To: <C1A2D784.5D2D%keir@xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612081336.59361.jesper.juhl@gmail.com>
	 <C1A2D784.5D2D%keir@xensource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/06, Keir Fraser <keir@xensource.com> wrote:
>
> On 8/12/06 12:36, "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> > (please keep me on Cc when replying)
> >
> > I have a server running Xen that regularly spews the following.
> > The box seems to survive fine regardless - just thought I'd let everyone know.
>
> Harmless and not entirely unexpected. I'll add __GFP_NOWARN to the
> allocations to quieten things down.
>
Ok, great. Thank you. :-)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
