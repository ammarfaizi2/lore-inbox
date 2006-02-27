Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWB0UGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWB0UGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWB0UGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:06:41 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:39487 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932276AbWB0UGk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:06:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rGhxJoCdQ+b1Sype4yPGHYGPrdvadWX6wRU9rEplM+Wpc7nLLPSyEWZCT/Xu9vroBHMPOVCGynMNN9I+ucN4cWPCGG6HmX9DsVikdG0+jP9/fByIdM/Xt+KO5iprsUlq1hyYMMj13upNVrV5NrG823lrdhexgECJx0inlYc9Xs4=
Message-ID: <9a8748490602271206n63fb4f95g8bb15bad5e81bbb3@mail.gmail.com>
Date: Mon, 27 Feb 2006 21:06:39 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Cc: "Greg KH" <greg@kroah.com>, gregkh@suse.de,
       "Kay Sievers" <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org
In-Reply-To: <p7364n01tv3.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060227190150.GA9121@kroah.com> <p7364n01tv3.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb 2006 20:31:28 +0100, Andi Kleen <ak@suse.de> wrote:
> Greg KH <greg@kroah.com> writes:
>
> > Hi all,
> >
> > As has been noticed recently by a lot of different people, it seems like
> > we are breaking the userspace<->kernelspace interface a lot.  Well, in
> > looking back over time, we always have been doing this, but no one seems
> > to notice (proc files changing format and location, netlink library
> > bindings, etc.)
>
> Ok, but how do you plan to address the basic practical problem?
> People cannot freely upgrade/downgrade kernels anymore since udev/hal
> are used widely in distributions.
>

Just a datapoint: My distribution (Slackware) uses udev (but not hal)
and I move between lots of different 2.6.x kernels and even 2.4.x
kernels without problems.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
