Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVAZOAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVAZOAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVAZOAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:00:31 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:44005 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262299AbVAZOAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:00:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PgEnctZduxQFQmykxTYikXx2TmxNJFV3JW034DM7PpB5NsGP6U5XGbijuYnqZX4FiVe4qDMpGL4aqnMENB/e4F1aWH9fHSRpYIA+BjctkYwi52SWCI4SWbU8eBHeaa2hvp0+UMiEFYlf6aiOmJKVhYkgJ9XxdgJqP9qM1hBeVYI=
Message-ID: <d120d5000501260600fb8589e@mail.gmail.com>
Date: Wed, 26 Jan 2005 09:00:21 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Cc: Christoph Hellwig <hch@infradead.org>, Jean Delvare <khali@linux-fr.org>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1106737157.5257.139.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124213442.GC18933@kroah.com>
	 <20050124214751.GA6396@infradead.org>
	 <20050125060256.GB2061@kroah.com>
	 <20050125195918.460f2b10.khali@linux-fr.org>
	 <20050126003927.189640d4@zanzibar.2ka.mipt.ru>
	 <20050125224051.190b5ff9.khali@linux-fr.org>
	 <20050126013556.247b74bc@zanzibar.2ka.mipt.ru>
	 <20050126101434.GA7897@infradead.org>
	 <1106737157.5257.139.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 13:59:17 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> On Wed, 2005-01-26 at 10:14 +0000, Christoph Hellwig wrote:
> > On Wed, Jan 26, 2005 at 01:35:56AM +0300, Evgeniy Polyakov wrote:
> > > I have one rule - if noone answers that it means noone objects,
> > > or it is not interesting for anyone, and thus noone objects.
> >
> > That's simply not true.  The amount of patches submitted is extremly
> > huge and the reviewers don't have time to look at everythning.
> >
> > If no one replies it simply means no one has looked at it in enough
> > detail to comment yet.
> 
> That is why I resent it several times.
> Then I asked for inclusion.
> 
> I never send it to lkml just because simple static/non static + module
> name
> discussion in lkml already overflowed into more than 20 messages...

Well, not everyone is subscribed to lm_sensors mailing list but
nonetheless are interested when a new subsystem is introduced into the
kernel. There several established subsystems (network, USB, ide) whose
maintainers people trust either because of the good track record or
because it affects small number of people so the main discussion is
kept on special lists. But even then most patches are presented on
LKML when issues ironed out on special list.

With a new subsystem it is wise to present it to LKML so it gets wider coverage.

-- 
Dmitry
