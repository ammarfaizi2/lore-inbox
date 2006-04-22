Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWDVQtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWDVQtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 12:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWDVQtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 12:49:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:1832 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750700AbWDVQtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 12:49:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k0GPwwqjxzIMGhs4NMpcwj44LKQJsmcVQ5KL6vU9aCOAOl7lz7bmISH5un8EERavr+Bh1cKlkqbzrK0ZjCoYX1neLp/dSjj/GDH13iNfnIqnk0IHuiJVbymR6qA1mW+LOCDXTBmJgjVn8KnTLVgI16babDr5jRbYs70ZOtfBkKg=
Message-ID: <4789af9e0604220949i2757e408qa5de3a9e728e966f@mail.gmail.com>
Date: Sat, 22 Apr 2006 10:49:14 -0600
From: "Jim Ramsay" <kernel@jimramsay.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Fw: Possible MTD bug in 2.6.15
Cc: "Thiago Galesi" <thiagogalesi@gmail.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1145723704.3524.TMDA@mail.tag.jimramsay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145723704.3524.TMDA@mail.tag.jimramsay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Pekka Enberg" <penberg@cs.helsinki.fi>
>
> On 4/19/06, Thiago Galesi <thiagogalesi@gmail.com> wrote:
> > Ok, a couple of comments/questions
> >
> > 1 - Wouldn't it be better to map all flash, and leave the unneeded
> > part as read only?

In general, yes.  But this should either be enforced somewhere nicer
(ie, die gracefully) so the kernel doesn't panic later, or be allowed
as in my patch.

> > 2 - Please follow  Documentation/SubmittingPatches format for sending
> > patches (especially the signed-off part and sending patches inline)
> >
> > 3 - No C++ style comments, please
>
> 4 - Read Documentation/CodingStyle before resubmitting the patch.

My apologies, I will do so, and resubmit when the patch is ready :)

--
Jim Ramsay
"Me fail English?  That's unpossible!"
