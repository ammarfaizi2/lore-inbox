Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRJaKNn>; Wed, 31 Oct 2001 05:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280134AbRJaKNd>; Wed, 31 Oct 2001 05:13:33 -0500
Received: from [195.66.192.167] ([195.66.192.167]:47116 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280132AbRJaKN2>; Wed, 31 Oct 2001 05:13:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Robert Love <rml@tech9.net>; J Sloan" <jjs@lexus.com>
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
Date: Wed, 31 Oct 2001 12:10:38 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <01102919120800.05333@nemo> <3BDDA646.B5D0E526@lexus.com> <1004388815.805.11.camel@phantasy>
In-Reply-To: <1004388815.805.11.camel@phantasy>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01103112103801.00794@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I narrowed down Samba weirdness I observe on 2.4.10 to preempt patch.
> > > Plain 2.4.10 works fine, 2.4.10+preempt (with latency measurement
> > > turned on) is sometimes oopses, and sometimes reports 'file already
> > > exists' when I attempt to copy a file from WinNT box to Linux.
> > > Sometimes it works ok (50% or so...)
> >
> > Why not try a recent kernel + preempt?
>
> Yes, would you mind retesting on a recent kernel and a recent patch?

2.4.13+preempt exhibits the same bug (latency measurement patch not applied).

I am still very willing to help in stomping on this bug.
--
vda 
