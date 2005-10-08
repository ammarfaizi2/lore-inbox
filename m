Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVJHPB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVJHPB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 11:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJHPB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 11:01:27 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:35356 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932148AbVJHPB0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 11:01:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=orr0KS7d/6FnVLZnUShND9LkdzcJmqAO7FXRJRz6E977QweW9YVyZcooA5WJIUCe5iU7LWMravzNgIWqQmS6s3gZkZ73w6K8Qh4V3YrSmdqRazTqEfTZIurPr6pSc3rNbzgYQZHXtz7jKd9zx2sVlFudcg+yCl4M2DtBwua7WYU=
Message-ID: <355e5e5e0510080801p88f04c7x7992c3d75f20e65c@mail.gmail.com>
Date: Sat, 8 Oct 2005 11:01:25 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
Cc: linux-kernel@vger.kernel.org, Molle Bestefich <molle.bestefich@gmail.com>,
       htejun@gmail.com, linux-raid@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <200510081555.41159.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510071111.46788.andrew@walrond.org>
	 <43477836.6020107@gmail.com>
	 <62b0912f0510080726ge2436e9ra6d7e8d17d1001ee@mail.gmail.com>
	 <200510081555.41159.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/05, Andrew Walrond <andrew@walrond.org> wrote:
> The lack of hot swapping does seem to be a serious weakness in linux, at least
> for resilient server applications. It would really complete the linux raid
> picture, and make it quite compelling.
>
> But I'm in no position to do it myself; I can only hope this thread inspires
> some capable person to plug the gap :)

Hey Andrew,

I've actually been working on implementing the core set of routines
that will allow for hot-swapping SATA drives in Linux.  The core is
not quite ready yet, but you can expect the next iteration within the
week.  Once the core is integrated, someone will have to implement
capturing hotswap events on the nForce4 SATA controller, and using the
core functions.  I don't know how long that will take, but if the
Linux SATA maintainer, Jeff Garzik (CCed on this email) knows how to
do it, then it might be just a few weeks' time.

That said, if you want to use this for servers you might still want to
wait a bit before committing your resources to this :)

Luke Kosewski
