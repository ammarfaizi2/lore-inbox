Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVIGLeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVIGLeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVIGLeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:34:50 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:40543 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932115AbVIGLet convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:34:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CA9KHKLBARxB98SBYAge7WmoNnO6lYtPqPmJ+7wKtxpg1nBE1pWTowlc9xlgLHIEWg1pKsKJHqf3rrpGtJdeYobzUn9iaItdmVeUPIeaGV9opRwY9yWrL/GRV1AWPL3D+SmZb1pEwdg37S8nwvg6MWCCy0kapgROaPvirq7lkpc=
Message-ID: <9cfa10eb050907043443325b89@mail.gmail.com>
Date: Wed, 7 Sep 2005 14:34:43 +0300
From: Marko Kohtala <marko.kohtala@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 00/10] parport: ieee1284 fixes and cleanups
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050907023159.15352a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050905183109.284672000@kohtala.home.org>
	 <20050907023159.15352a82.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, Andrew Morton <akpm@osdl.org> wrote:
> marko.kohtala@gmail.com wrote:
> > This is a collection of the changes I have made. They have been through
> > linux-parport mailing list already in January and they have been modified
> > according to comments.
> 
> umm, OK.  parport patches worry me because nobody seems to understand the
> code any more.  We'll see.

Thanks. I'm worried too.

>From the responses in linux-parport I gathered some of the bugs are
there because people have not used the code. Therefore I also
considered removing it would be good, but was afraid to do so.

Also there are drivers that would have use for it, but they just are
currently implemented either by just reserving the whole parport and
then doing their daisy chain magic.

> You just sent ten patches, all with the same name.  This causes me grief
> (See http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, section 2a).

I used "quilt mail" to send those patches and it seems it requires
some additional trick I did not notice to make the patches have
different subjects. I had read the document you referred to but missed
that part. I also had picked somewhere the idea that having same
subject helped group the patches.

> I now need to invent names for your patches, and if I later refer to one of
> them you won't know which one I'm talking about.  Oh well.

I can also resend the patches to you. I understand you have a lot to
do already and I want to be of help, not burden.
