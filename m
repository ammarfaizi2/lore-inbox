Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280402AbRKSRZo>; Mon, 19 Nov 2001 12:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280343AbRKSRZd>; Mon, 19 Nov 2001 12:25:33 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:21435 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280364AbRKSRZW>; Mon, 19 Nov 2001 12:25:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 17:24:59 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl>
In-Reply-To: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165sA9-0006Nv-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 4:44 pm, Horst von Brand wrote:
> vda <vda@port.imtp.ilyichevsk.odessa.ua> said:
>
> [...]
>
> > > [james@dax p2i]$ ls test
> > > ls: test/file: Permission denied
> > > [james@dax p2i]$ ls -l test
> > > ls: test/file: Permission denied
> > > total 0
> >
> > Looks like we have different ls :-). Mine lists 'r only' dir with no
> > problem.
>
> Probably some alias. "/bin/ls test" should work, "/bin/ls -l test" won't.

Correct: my default ls is trying to stat the files to pick a pretty color for 
them...

> > > Anyway, as Al Viro has pointed out, R!=X. It's been like that for a
> > > very long time, it's deliberate, not a misfeature, and it's staying
> > > like that for the foreseeable future.
> >
> > Yes, I see... All I can do is to add workarounds (ok,ok, 'support')
> > to chmod and friends:
> >
> > chmod -R a+R dir  - sets r for files and rx for dirs
>
> X sets x for dirs, leaves files alone.

Which sounds like exactly the behaviour the original poster wanted, AFAICS?


James.
