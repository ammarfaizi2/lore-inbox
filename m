Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279998AbRKSQqW>; Mon, 19 Nov 2001 11:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRKSQqN>; Mon, 19 Nov 2001 11:46:13 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:64261 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S280015AbRKSQqB>; Mon, 19 Nov 2001 11:46:01 -0500
Message-Id: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature? 
In-Reply-To: Message from vda <vda@port.imtp.ilyichevsk.odessa.ua> 
   of "Mon, 19 Nov 2001 18:24:11 -0000." <0111191824110B.00817@nemo> 
Date: Mon, 19 Nov 2001 13:44:47 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda <vda@port.imtp.ilyichevsk.odessa.ua> said:

[...]

> > [james@dax p2i]$ ls test
> > ls: test/file: Permission denied
> > [james@dax p2i]$ ls -l test
> > ls: test/file: Permission denied
> > total 0
> 
> Looks like we have different ls :-). Mine lists 'r only' dir with no
> problem.

Probably some alias. "/bin/ls test" should work, "/bin/ls -l test" won't.

> > Anyway, as Al Viro has pointed out, R!=X. It's been like that for a very
> > long time, it's deliberate, not a misfeature, and it's staying like that
> > for the foreseeable future.
> 
> Yes, I see... All I can do is to add workarounds (ok,ok, 'support')
> to chmod and friends:
> 
> chmod -R a+R dir  - sets r for files and rx for dirs

X sets x for dirs, leaves files alone.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
