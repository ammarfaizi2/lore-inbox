Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbWGJNNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWGJNNR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWGJNNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:13:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:44363 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964886AbWGJNNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:13:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K3pKUI735rMdmig2ae3pl8NRpW95shB4aARb4w1tA2P9Mjp1ymByIZtXKHWaK1QCzm6H6oqkXsGJMaW0GxZc2x2nONEtpjuAG9rQJ3JLLOPWk2UADXFWerXe7nEz4/wsLAr/OB9f7gieunjhrN7JPI+/YoKaDiqFL+wTetAZgLI=
Message-ID: <9a8748490607100613s2489d656g430b80ee06e51782@mail.gmail.com>
Date: Mon, 10 Jul 2006 15:13:14 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1152536791.4874.43.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490607100548o14dbe684j40bde90eb19a7558@mail.gmail.com>
	 <1152535999.4874.36.camel@laptopd505.fenrus.org>
	 <d120d5000607100603r7ac59457tc1b080a15ed84db3@mail.gmail.com>
	 <1152536791.4874.43.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 2006-07-10 at 09:03 -0400, Dmitry Torokhov wrote:
> >
> > While we may not have any issues with the present code it can help
> > avoiding problems in new code if we have -Wshadow by default.
>
> I agree with that; however that still depends on the ratio of real bugs
> vs "noise". While it's hard to estimate for future code, the existing
> code base can be an indication...
>
One little twist here is that if I end up going through all the
current warnings to clean them up then once I know that ratio I'll
have already done all the cleanup work, so whatever the bugs/noise
ratio turns out to be, all the work will already be done and then
(from my point of view) we might as well do it ;-)

More seriously; I'll try and sift through the pile I have at the
moment and pick out those that look like real bugs, then we can look
at that and see if it's worth-while...
In any case, even if there are only very few real bugs (or even none)
I'm still full willing to do the work to help us protect against
future bugs.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
