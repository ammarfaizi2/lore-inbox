Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263422AbRFNRTh>; Thu, 14 Jun 2001 13:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbRFNRTT>; Thu, 14 Jun 2001 13:19:19 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:54912 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263416AbRFNRTO>; Thu, 14 Jun 2001 13:19:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: David Luyer <david_luyer@pacific.net.au>,
        Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Download process for a "split kernel" (was: obsolete code must die)
Date: Thu, 14 Jun 2001 08:18:21 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, esr@thyrsus.com
In-Reply-To: <200106141207.f5EC7CA4030080@pincoya.inf.utfsm.cl> <200106141214.f5ECEaL3022945@typhaon.pacific.net.au>
In-Reply-To: <200106141214.f5ECEaL3022945@typhaon.pacific.net.au>
MIME-Version: 1.0
Message-Id: <01061408182106.01082@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 08:14, David Luyer wrote:

> Well, I'm actually looking at the 2nd idea I mentioned in my e-mail -- a
> very small "kernel package" which has a config script, a list of config
> options and the files they depend on and an appropriately tagged CVS tree
> which can then be used for a compressed checkout of a version to do a
> build.  (Or maybe something more bandwidth-friendly than CVS for the
> initial checkout.)
>
> Maybe I'll find the spare time to do it, maybe I won't, either way I won't
> post any more on the subject until I have something tangible (so far I've
> just done the 'easy bit': written a quick shell script which imported 2.4.x
> into a tagged CVS tree; the 'hard bit', to write a script to analyse each
> kernel rev and determine which files are used by which config options and
> mix that in together with the minimal install for a 'make menuconfig' will
> take somewhat longer).
>
> David.

You might want to float this idea by Eric Raymond.  It's POSSIBLE (distant 
but possible) that the new CML2 stuff might make this sort of thing easier to 
automate.

Correction, it's possible CML2 might make this POSSIBLE to automate.  It 
sounds like it would still be a female dog and a half to implement.  But I'm 
not the one to ask...

Rob
