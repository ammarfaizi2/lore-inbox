Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946750AbWKJQQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946750AbWKJQQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946747AbWKJQQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:16:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:28957 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946723AbWKJQQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:16:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hW0NyKSl+CiD8pza+GgoVPIG4r7kk9QukTOIkS7rpIA20Rnv8iTjVchH4Cr3c5chSuKzmSYjBf2P2M/fr7cuhVwJuGtGKs+Jx+6+5CvGiWXrs2x9BEAp1wfND5/QtrgioPpbFct4Bu6NBOWGmYYTRsnyiEUPRWg/br9+aUX1Fo4=
Message-ID: <9a8748490611100816v573418f4gcd5cbe34d0dd3715@mail.gmail.com>
Date: Fri, 10 Nov 2006 17:16:13 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Al Boldi" <a1426z@gawab.com>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Cc: "Stephen Hemminger" <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200611101852.14715.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611090757.48744.a1426z@gawab.com>
	 <20061109090502.4d5cd8ef@freekitty>
	 <200611101852.14715.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/06, Al Boldi <a1426z@gawab.com> wrote:
> Stephen Hemminger wrote:
[...]
> > There are bugfixes which are too big for stable or -rc releases, that are
> > queued for 2.6.20. "Bugfix only" is a relative statement. Do you include,
> > new hardware support, new security api's, performance fixes.  It gets to
> > be real hard to decide, because these are the changes that often cause
> > regressions; often one major bug fix causes two minor bugs.
>
> That's exactly the point I'm trying to get across; the 2.6 dev model tries to
> be two cycles in one, dev and stable, which yields an awkward catch22
> situation.
>
> The only sane way forward in such a situation is to realize the mistake and
> return to the focused dev-only / stable-only model.
>
> This would probably involve pushing the current 2.6 kernel into 2.8 and
> starting 2.9 as a dev-cycle only, once 2.8 has structurally stabilized.
>

That was not what I was arguing for in the initial mail at all.
I think the 2.6 model works very well in general. All I was pushing
for was a single cycle focused mainly on bug fixes once in a while.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
