Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751935AbWI3UwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbWI3UwO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWI3UwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:52:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:45248 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751935AbWI3UwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:52:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NYqWaM8Dfvnx2uvvkDskXH3FohDmMkQ0a+b8n4Y0nVC2toWXczRrtM8CkrkFPbIuvdY4wDJSK9sR3cPHm5xOI7UHXFkk1e6OKNU1ma+GL9F0Wa7rBwajjjMVMx/W9XScS5Eqj/9p/LBrDFF4GPS8wycT+Wpr8RNXovrQYWNHu6s=
Message-ID: <5f3c152b0609301352w5bc52653s3e2a28e482c7d69e@mail.gmail.com>
Date: Sat, 30 Sep 2006 22:52:12 +0200
From: "Eric Rannaud" <eric.rannaud@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       mingo@elte.hu, nagar@watson.ibm.com
In-Reply-To: <20060930131310.0d6494e7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
	 <20060930131310.0d6494e7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Andrew Morton <akpm@osdl.org> wrote:
> > On  a 16-way Opteron (8 dual-core 880) with 8GB of RAM, vanilla 2.6.18
> > crashes early on boot with a BUG.
>
> omg what a mess.  Have you tried it with lockdep disabled in config?

Well, all I can say is that without lockdep it doesn't freeze right
away (and no BUG, but that's to be expected). I can stress test it if
you want, although it will take a while, if you think it might be a
false positive.

er.
