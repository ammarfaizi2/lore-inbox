Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWAKMgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWAKMgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWAKMgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:36:50 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:1291 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751446AbWAKMgs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:36:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JP+1ZVhP2w5UqNT71fmf4Ocf/utKrSYekqIaskYs59u6tYJJUNgpe1aHvMomvpxS6YKh51mfpq4p/hSRzKjscCev3WkVYTHexU2tZb0E5clPN6InwNkts7mqxaUVGCtYH3Mka4Duj4J4Pg27RypileI5BKLSUkVC76n0vY5DsC4=
Message-ID: <4d8e3fd30601110436p286cfacap6618067c32e22a32@mail.gmail.com>
Date: Wed, 11 Jan 2006 13:36:48 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: why no -mm git tree?
Cc: Coywolf Qi Hunt <qiyong@fc-cn.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060110231818.6164dba7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060111055616.GA5976@localhost.localdomain>
	 <20060110224451.44c9d3da.akpm@osdl.org>
	 <20060111070043.GA7858@localhost.localdomain>
	 <20060110231818.6164dba7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Andrew Morton <akpm@osdl.org> wrote:
> Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> >
> > On Tue, Jan 10, 2006 at 10:44:51PM -0800, Andrew Morton wrote:
> > > Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> > > >
> > > > Why don't use a -mm git tree?
> > > >
> > >
> > > Because everthing would take me 100x longer?
> >
> > Really? So does Linus?
> >
>
> Linus does a totally different thing from me.
>
> He reverts about one patch a month.  I drop tens a day.
>
> He never _alters_ patches.  2.6.15-mm1 had about 200 patches which modify
> earlier patches and which get rolled up into the patch-which-they-modify
> before going upstream.
>
> He never alters the order of patches.
>
> etc.
>
> > >
> > > I'm looking into generating a pullable git tree for each -mm.  Just as a
> > > convenience for people who can't type "ftp".
> >
> > That doesn't help much if it's only for each -mm.
> > If you make git commits for each each patch merged in, then
> > we can always run the `current' -mm git tree.
>
> Ah.  If you're suggesting that the -mm git tree have _patches_ under git,
> and the way of grabbing the -mm tree is to pull everything and to then
> apply all the patches under the patches/ directory then yeah, that would
> work.
>
> But my tree at any random point in time is a random piece of
> doesn't-even-compile-let-alone-run crap, believe me.  Often not all the
> patches even apply.  I don't think there's much point in exposing people to
> something like that.

Andew,
did you consider Stacked GIT as an alternative to quilt ?

--
Paolo
