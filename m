Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWFLVKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWFLVKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWFLVKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:10:42 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:41763 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932258AbWFLVKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:10:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e0P1unKIL013sKCfGeDkOZFMCNwqeWnIoiLYUHuAiyY0FD1WLdzAtxoMb2LXL36lAp1WHInqSek/ULvxC2m4PZqadYHhItWY2Id+AVczFCGND+pf/3WN75CAdZlQEQU83uS5EkCHsL3PpfcUJA5BANSBYEGuWniw2xd76sLmllg=
Message-ID: <7c3341450606121410y7f2349e1y7d8ecf3f3873732@mail.gmail.com>
Date: Mon, 12 Jun 2006 22:10:41 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Cc: "Bernd Petrovitsch" <bernd@firmix.at>, "marty fouts" <mf.danger@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606122025.k5CKPTGB005597@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bernd@firmix.at> <1150100843.26402.22.camel@tara.firmix.at>
	 <200606122025.k5CKPTGB005597@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been following this closely, and without getting into the
discussion re SPF, I think one issue especially affecting LKML is the
traffic.

One (almost sure) fire way to stop the spam is to make a subscribed
ML.  But people like myself cannot/have not the resource to take on
the 200+ mails a day (how the kernel devs manage it, I don't know?).

So I have subscribed via my gmail account to follow the mails, but
then at least I can reply from my 'real address' and keep the thread
intact (if you see what I mean).

So, why not make the list a subscribe only list to SEND, but give an
option to NOT receive any mail from the list unless CC'ed?

Nick

On 12/06/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Bernd Petrovitsch <bernd@firmix.at> wrote:
> > On Sat, 2006-06-10 at 19:24 -0700, marty fouts wrote:
>
> [...]
>
> > > It doesn't work.
>
> > It works if it is used correctly (as any tool in the world).
>
> Right.
>
> > The "problem" is that postmasters on the Net must do something
>
> It took /years/ until open relays weren't common anymore... and that is a
> /simple/ measure, on by default in newer upstream packages, no admin
> intervention required. DNS works badly, here in Chile a mayor ISP had a
> totally broken setup for many years.
>
> >                                                                (namely
> > 1) define if they want to allow others to detect forged emails claimed
> > to come from their domain
>
> They have /very/ little to gain by that, and setting it up correctly is a
> mayor hassle. It breaks people sending mail "from" the domain when they
> aren't there (this is rather common for people on the road), and has no
> real fix. I.e., it won't ever be done. Or it will be tried, some email from
> Big Cheese doesn't go through, and it will be axed.
>
> >                           and 2) - if yes to 1) - to get appropriate SPF
> > records into DNS)
>
> Many people have no (or very little) control over their DNS data. A spammer
> can then just claim it comes from one of the millions of SPF-less domains
> in the world (if they don't set up their own SPFied one...). Besides,
> discussions on the spamassassin lists show that SPFied email is a rather
> reliable indicator of spam as things stand today...
>
> >                   and people must either use a "good" mail relay (and
> > not just the one next door) or convince postmasters to change the SPF
> > records.
>
> Won't happen.
>
> > > It'll break standard-abiding email.
>
> > As you see, standards change.
>
> Yep. But SPF breaks email, not just changes the standard. For no gain at
> all.
>
> > > Do you really want that?
>
> > Yes. Especially gmail.com should do such a thing - there is such a lot
> > of - presumbly forged - @gmail.com mails in my mailboxes that
> > blacklisting the whole domain causes probably more good than bad (for
> > me, of course).
>
> There is spam that really comes from gmail...
> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
