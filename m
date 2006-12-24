Return-Path: <linux-kernel-owner+w=401wt.eu-S1752749AbWLXUzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbWLXUzE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 15:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbWLXUzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 15:55:04 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:50952 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbWLXUzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 15:55:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uGTtbdCETDVFqGQoZEKaAuvt2i2pTr9pk5rdyt9h4AlNcSbFm7pnCuS2mcdU95R6yJq+7MWD2KXV3Ml4sodxNkE9arVNowPQGEhz7NqHQjZHMhpb7LyncFdE5bFdtcam1sRX6RSBkJ7bmMT66py0uzU46Ja/OQ0BrutU1GcXlVI=
Message-ID: <97a0a9ac0612241255o1d5766cevfe2664c95244f02a@mail.gmail.com>
Date: Sun, 24 Dec 2006 13:55:01 -0700
From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>,
       "Andrew Morton" <akpm@osdl.org>, "Martin Michlmayr" <tbm@cyrius.com>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	 <20061224005752.937493c8.akpm@osdl.org>
	 <1166962478.7442.0.camel@localhost>
	 <20061224043102.d152e5b4.akpm@osdl.org>
	 <1166978752.7022.1.camel@localhost>
	 <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/06, Linus Torvalds <torvalds@osdl.org> wrote:

> Ok, so how about this diff.
>
> I'm actually feeling good about this one. It really looks like
> "do_no_page()" was simply buggy, and that this explains everything.

I tested with just this patch and 2.6.19 and no change. Sorry Linus,
no early Christmas present :-(

Gordon

-- 
Gordon Farquharson
