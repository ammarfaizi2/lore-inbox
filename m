Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWCHCwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWCHCwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWCHCwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:52:07 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:13940 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932349AbWCHCwG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:52:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=foUFSmb2zNhN6RV/JimDgpHstOR1Mu8pY9nriL+qZ49kNOK5uZC+/80y4W9ItN3jHUsg4E1r6fhUArl7fKS3WHI27Ks5CaFPSiqJpRJg1xyq66ezY9HSUGJwnLeoFfxlhJWEH46GGj60nnR6LUpwvB7VOyvWfw6FktmIPWwGkZQ=
Message-ID: <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com>
Date: Tue, 7 Mar 2006 22:52:05 -0400
From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: [ck] Re: [PATCH] mm: yield during swap prefetching
Cc: "Lee Revell" <rlrevell@joe-job.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <200603081330.56548.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200603081013.44678.kernel@kolivas.org>
	 <200603081322.02306.kernel@kolivas.org>
	 <1141784834.767.134.camel@mindpipe>
	 <200603081330.56548.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> > > Because being a serious desktop operating system that we are
> > > (bwahahahaha) means the user should not have special privileges to run
> > > something as simple as a game. Games should not need special scheduling
> > > classes. We can always use 'nice' for a compile though. Real time audio
> > > is a completely different world to this.
[...]
> Well as I said in my previous reply, games should _not_ need special
> scheduling classes. They are not written in a real time smart way and they do
> not have any realtime constraints or requirements.

Sorry Con, but I have to disagree with you on this.

Games are very complex software, involving heavy use of hardware resources
and they also have a lot of time constraints. So, I think they should
use RT priorities
if it is necessary to get the resources needed in time.

Thanks,
--
[]s,

André Goddard
