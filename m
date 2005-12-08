Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVLHCqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVLHCqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 21:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVLHCqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 21:46:06 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:47015 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964829AbVLHCqF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 21:46:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m0BSdLVuD8OcRhSmZWvYVqhWKM/cjijbih8wUdsi7DOdrXU/6mfHJ3JWxND81R6qjimZ0RbvF5P8PieKA43XMk1Xzl6vI/1H5z6HEBHgp+cnGwJ8SrOBSkn8SwCPKK2SVWdMRGBOkNiZFqR3JEM7cQ3REJWqpreLiAcWDsQ8jUA=
Message-ID: <3aa654a40512071846j247bd4a2r264da0904fa300fb@mail.gmail.com>
Date: Wed, 7 Dec 2005 18:46:04 -0800
From: Avuton Olrich <avuton@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Kernel panic: Machine check exception
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m1wtiicwbv.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	 <1132406652.5238.19.camel@localhost.localdomain>
	 <3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
	 <1132436886.19692.17.camel@localhost.localdomain>
	 <m1wtiicwbv.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
> In this case bank 4 is the appropriate bank.  Although the
> other bits don't look right for a memory error.  I wonder
> if it is that darn iommu fault again.

You know, I have to say you _have_ to be right. While the MCE happens
at random times, since I've compiled without IOMMU in it has been
smooth sailing, when normally I would have locked up a few times by
now (Right after I send out this reply surely it will lockup). So, I
will end this thread by saying with that if you're using a Gigabyte
K8N51GMF-9 it's advisable to turn off IOMMU for now, if you get
lockups.

--
avuton
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
