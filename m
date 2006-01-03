Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWACVom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWACVom (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWACVom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:44:42 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:15469 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964950AbWACVol convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:44:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OAVIdosEtEAxrynSBVSPg+pGvZ1+sEL1/k1VY/PeqUg34SwnpbgKr+gYLFMHhjneNMTccfsZ0HrqnuykEjUviI/nJzAtzCDT7vhFU2c3K9LbEJZz0OuhGcii2QhVFc1yZdlHZfJPoBE5RxbSkaYw50QAFWaAtLo4zbdfOq84Qhg=
Message-ID: <9a8748490601031344n5b2066e4y7b989e0ace1e71a7@mail.gmail.com>
Date: Tue, 3 Jan 2006 22:44:39 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Avishay Traeger <atraeger@cs.sunysb.edu>
Subject: Re: Benchmarks
Cc: Sharma Sushant <sushant@cs.unm.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1136324365.21485.19.camel@rockstar.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103213244.M41864@webmail.cs.unm.edu>
	 <1136324365.21485.19.camel@rockstar.fsl.cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Avishay Traeger <atraeger@cs.sunysb.edu> wrote:
> Well that would very much depend on what you're changing.  For example,
> if it is a file system modification, then use file system benchmarks.
> However, those same benchmarks would not be appropriate for changes in
> the network stack.  A pre-written benchmark may not even exist.  You
> should use your knowledge of what you are changing to choose an
> appropriate benchmark that will stress that part of the kernel.
>
Or, as is often the case, write a benchmark app yourself to test the
specific thing you've changed.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
