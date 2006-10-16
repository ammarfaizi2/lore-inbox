Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWJPOYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWJPOYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJPOYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:24:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:47156 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750714AbWJPOYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:24:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rUwZY40u2YQIqeJKVUPEPwZZN7/CmRCc/LrRBAzq6p2uPb5EFyx47uOByGOb0brDdqqKq/YFCIrSjGy6ttOaWbI7PfXtr38yGKtvBWiMh4ZgDUIvJnBgzfKt/A2XMxJJahghrXrdDWJq072Pqeyn6Ec3at5QSsNyjV5wwhIhonc=
Message-ID: <9a8748490610160724l2a5c6cd6k1a984d10e947eda6@mail.gmail.com>
Date: Mon, 16 Oct 2006 16:24:38 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Constantine Gavrilov" <constg@qlusters.com>
Subject: Re: Would SSI clustering extensions be of interest to kernel community?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45337FE3.8020201@qlusters.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45337FE3.8020201@qlusters.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/06, Constantine Gavrilov <constg@qlusters.com> wrote:
> I have implemented SSI (single system image) clustering extensions to
> Linux kernel in the form of a loadable module.
>
> It roughly mimics OpenMosix model of deputy/remote split (migrated
> processes leave a stub on the node where they were born and depend on
> the "home" node for IO).
>
> The implementation shares no code with Mosix/Open Mosix (was written
> from scratch), is much smaller, and is easily portable to multiple
> architectures.
>
> We are considering publication of this code and forming an open source
> project around it.
>
> I have two questions to the community:
>
> 1) Is community interested in using this code? Do users require SSI
> product in the era when everybody is talking about partitioning of
> machines and not clustering?

Some users require SSI clustering and some just like playing with it.
In any case, more options than those available currently can only be
good :)

> 2) Are kernel maintainers interested in clustering extensions to Linux
> kernel? Do they see any value in them? (Our code does not require kernel
> changes, but we are willing to submit it for inclusion if there is
> interest.)
>
I'm sure there's interrest in at least seeing it.
You should consider cleaning up your code according to
Documentation/CodingStyle first though (if it doesn't already follow
it) or your first batch of feedback is probably just going to be a
bunch of style cleanup requests ;)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
