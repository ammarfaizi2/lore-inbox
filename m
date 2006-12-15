Return-Path: <linux-kernel-owner+w=401wt.eu-S1752690AbWLOOw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbWLOOw7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbWLOOw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:52:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:64719 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbWLOOw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:52:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W4DszSe0su0CkB5AJUoSibBEs89JJ4J24UF/+zIc45rqZKA3RsQfBKMPa7sr37CimTfoSG4eAaUcRudSYEeqCkVqVFsMhg+09zOf0TvrVtgnUHChYRxolhxKhYBfaR0nKQ5b47TU1mPVE1ENUVS3CS7EMrNKU3yJ50nYsWmhA2A=
Message-ID: <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
Date: Fri, 15 Dec 2006 08:52:22 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH/v2] CodingStyle updates
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Randy Dunlap" <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, jesper.juhl@gmail.com,
       akpm <akpm@osdl.org>
In-Reply-To: <20061215142206.GC2053@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
	 <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de>
	 <20061215142206.GC2053@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > Pavel Machek wrote:
> > >> From: Randy Dunlap <randy.dunlap@oracle.com>
> > >> +Use one space around (on each side of) most binary and ternary operators,
> > >> +such as any of these:
> > >> +  =  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
> > >
> > > Actually, this should not be hard rule. We want to allow
> > >
> > >     j = 3*i + l<<2;
> >
> > Which would be very misleading. This expression evaluates to
> >
> >       j = (((3 * i) + l) << 2);
> >
> > Binary + precedes <<.
>
> Aha, okay. So this one should be written as
>
>         j = 3*i+l << 2;
>
> (Well, parenthesses should really be used. Anyway, sometimes grouping
> around operator is useful, even if I made mistake demonstrating that.
---

I think the mistake illuminates why parentheses should be the rule. If
you're thinking about using spacing to convey grouping, use
parentheses instead...

scott
