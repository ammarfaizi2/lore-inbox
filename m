Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVLAIGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVLAIGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 03:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVLAIGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 03:06:00 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:6643 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750760AbVLAIF7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 03:05:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b5g494htf1ZI1hKL7GwdsKjqnYIKCUuwxj0VP3U5ZugidFKEl1uFCHGhGndo4y8CFJIvDYm0Im5qOKZDq30xXoYVkaLFzb1tO/kMFVq1q2kberk0Bxe3BcFB9PB6ipXSeSCgk65kbK00rD28t5gn0eTiBtntumezCkcy3bcUMMI=
Message-ID: <cda58cb80512010005h24c3754ex@mail.gmail.com>
Date: Thu, 1 Dec 2005 09:05:58 +0100
From: Franck <vagabon.xyz@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Add MIPS dependency for dm9000 driver
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20051130132757.36e1cca0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511300918i7df1c60au@mail.gmail.com>
	 <20051130132757.36e1cca0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

2005/11/30, Andrew Morton <akpm@osdl.org>:
> Franck <vagabon.xyz@gmail.com> wrote:
> >
> > The attached patch adds MIPS dependency for dm9000 ethernet
> > controller. Indeed this controller is used by some embedded platforms
> > based on MIPS CPUs.
> >
>
> Is there any reason why we cannot enable this driver on all architectures?
>
> It's moderately important for quality and maintainability reasons that it
> be included in the x86 build, at least..
>

Actually there's a discussion about that. I previously sent a RFC
(subject is "[NET] Remove ARM dependency for dm9000 driver") for that.
Now some people are reacting so we should wait for the last words
before applying something.

thanks
--
               Franck
