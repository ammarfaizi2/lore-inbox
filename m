Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVHQLFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVHQLFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVHQLFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:05:38 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:23203 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751061AbVHQLFh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:05:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K3eppzcaHP4vUarHGwHWVqV3sPI3wUJqfcvMcoWUpBkpA2SJfqE1Njjjz2pMupgPhEHGsOkldUZxTQt0Yg69dHOQ7Fpx6NoxhmHHRZ94DNBCwr/UmxB0onD76c7Gq87PgIaQQ4L05nTuAIpOQxueswsyrvCvrCACZPLCkQp0ooM=
Message-ID: <21d7e997050817040523a1bf46@mail.gmail.com>
Date: Wed, 17 Aug 2005 21:05:34 +1000
From: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: rc6 keeps hanging and blanking displays
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <43031A12.8020301@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42F89F79.1060103@aitel.hist.no>
	 <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
	 <20050815221109.GA21279@aitel.hist.no>
	 <21d7e99705081516182e97b8a1@mail.gmail.com>
	 <21d7e99705081516241197164a@mail.gmail.com>
	 <20050816165242.GA10024@aitel.hist.no>
	 <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
	 <20050816211424.GA14367@aitel.hist.no>
	 <21d7e99705081616504d28cca5@mail.gmail.com>
	 <43031A12.8020301@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >I'm still pointing towards that assign pci resources patch from Gregs
> >tree that I mentioned earlier..
> >
> >
> git is completely new to me - is there a git-specific way to get this
> patch, or should I download it the usual way from somewhere?

Just grab it from the link to comment #16 on 
http://bugzilla.kernel.org/show_bug.cgi?id=4965

and revert it if you could, thanks...

> That was strange, sure.  Could be a different bug too.

oh it more than likely is a different bug...
> 
> >I'm running low on ideas, I'm also having a hard time tracking what is
> >actually happening,  the MGA bugs I've tracked are related to that
> >assign pci resources patch, and I really can't see what is happening
> >if the DRM isn't in the mix..
> >
> >If you build a working kernel (i.e. like 2.6.13 without DRM) does it
> >hang similarly?
> >
> >
> >
> 2.6.13 isn't released, so I assume you meant some earlier kernel?
> I'll see if I can get a drm-less kernel running.

Oh yeah sorry, I meant 2.6.12 or some kernel you know works...

Dave.
