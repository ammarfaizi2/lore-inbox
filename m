Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVITXvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVITXvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVITXvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:51:04 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:58080 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750718AbVITXvD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:51:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=slg+xRXCpQieXR2p1ai56WDe++rNWHlXtpMiRaf32l1Qd6b/8PARIJAD3YMl0If3xWe68rObyoxCHv81BFniGQ0uDSOBiO4RcSSbazbaKiwYHS7DOOLBJA/BQeRfvVw+YqvxdQOXvnpDGxIWaYG0coBDcoYyo6QZiEqktspdKr4=
Message-ID: <aa4c40ff0509201651723bc624@mail.gmail.com>
Date: Tue, 20 Sep 2005 16:51:00 -0700
From: James Lamanna <jlamanna@gmail.com>
Reply-To: James Lamanna <jlamanna@gmail.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: stephen.pollei@gmail.com, vonbrand@inf.utfsm.cl, nikita@clusterfs.com,
       vda@ilport.com.ua, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.58.0509201644300.14402@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aa4c40ff05092015405a23f33a@mail.gmail.com>
	 <Pine.LNX.4.58.0509201644300.14402@shell3.speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> On Tue, 20 Sep 2005, James Lamanna wrote:
>
> > On 9/20/05, Stephen Pollei <stephen.pollei@gmai.com> wrote:
> > >On 9/20/05, Hans Reiser <reiser@namesys.com> wrote:
> > > > Horst von Brand wrote:
> > > > >Nikita Danilov <nikita@clusterfs.com> wrote:

> > What about #warning / #error in this case?
> >
> > #if defined(DEBUG_THIS) || defined(DEBUG_THAT)
> >     int znode_is_loaded(const struct znode *z);
> > #else
> >     #error znode_is_loaded is unavailable when not debugging
> > #endif
> >
> > That would certainly break the compile.
>
> Except that breaks the compile unconditionally, not just when someone
> tries to use the function when they shouldn't. I don't think a flat
> error will work here, but instead something along the lines of a
> __attribute__((error)) on the function is needed.

Oh duh. It would wouldn't it :)
Too much on my mind today.

>
> > -- James Lamanna
> > -
>
> -VadimL
>

-- James Lamanna
