Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVKUWLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVKUWLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVKUWLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:11:32 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:44155 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751125AbVKUWLa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:11:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lKMffBjjsnsy9rIVJyMr5D9YwL8Y49n/9wa5hFI7H8WKI/PK3PBA0iZWClcUJ10mZDyb2omSgSTpS5mXQ9yK7Zg3Fuag82PUnn02UuBEoQ6R+T5mk/3S1hqny0McIEarfZK7Jq28kH07cvFZfWU9TTp3f7gMPS8SQUb11xUoYuo=
Message-ID: <afcef88a0511211411v2c28e128u83fa52ab4ebf7382@mail.gmail.com>
Date: Mon, 21 Nov 2005 16:11:29 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 0/12: eCryptfs] eCryptfs version 0.1
Cc: Michael Halcrow <lkml@halcrow.us>, Andrew Morton <akpm@osdl.org>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <Pine.LNX.4.63.0511211631140.479@excalibur.intercode>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051118221659.64515ac0.akpm@osdl.org>
	 <20051121202825.GA17946@halcrow.us>
	 <Pine.LNX.4.63.0511211631140.479@excalibur.intercode>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, James Morris <jmorris@namei.org> wrote:
> On Mon, 21 Nov 2005, Michael Halcrow wrote:
>
> > I think you brought up two categories of potential security
> > vulnerabilities.
>
> > The first has to do with the theoretical security of
> > the algorithms -- do the encrypted files really have the attribute
> > such that decrypting the files without the proper key is
> > computationally infeasible? This is the job for the cryptographers to
> > confront.
> >
> > The other category has to do with ``exploits''; I assume you are
> > talking about -- for instance -- malicious files that are able to
> > circumvent the intended behavior of the code. Such vulnerabilities may
> > coerce the filesystem to dump the secret key out to an insecure
> > location. This is an extension of the general ``correctness'' problem
> > that can be an issue with any code. I would say that this is the job
> > of the engineers to help prevent. It basically involves verification
> > that eCryptfs is handling all of its memory correctly (i.e., via data
> > and control flow analysis).
>
> There's a third important category: the design of the _system_.
>
> (Which you end up discussing somewhat further in the email).
>
> It would be great to have a document which describes the design of the
> system and includes a comprehensive security analysis.

Kernel programmers making documentation? You must be joking! (Side
joke... someone somewhere, which I have now forgetten, made a similar
comment).

For documentation, nothing formal exists, and while we were planning
on having some, it sounds like it might be a good thing to start
sooner than later.

I (or someone else) will get back to you when we figure out how we
want to approach this.

>
>
> - James
> --
> James Morris
> <jmorris@namei.org>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
