Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282530AbRKZVIl>; Mon, 26 Nov 2001 16:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282543AbRKZVIb>; Mon, 26 Nov 2001 16:08:31 -0500
Received: from zero.tech9.net ([209.61.188.187]:17417 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282530AbRKZVIZ>;
	Mon, 26 Nov 2001 16:08:25 -0500
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
From: Robert Love <rml@tech9.net>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Didier.Moens@dmb001.rug.ac.be, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C022BB4.7080707@epfl.ch>
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be> 
	<3C022BB4.7080707@epfl.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 26 Nov 2001 16:07:28 -0500
Message-Id: <1006808870.817.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-26 at 06:47, Nicolas Aspert wrote:

> It seems like you have pointed out the problem... From what you had sent 
> previously (the output of 'lspci' on your machine), and what the Intel 
> doc says, it looks to me like the code for i830 initialization is not 
> correct for your version of the chipset. But I am not too sure of what 
> is to be done in that case... should we switch back to a 'classic' AGP 
> initialization, similar to the other i8xx chipsets (820/840/860...) ? 
> Robert (or somebody else), any clue about this one ?

It looks like you got it right ... at any rate, you know as much as me
about a chipset neither of us have (ie, we have docs), so its all a
guess.

Has the user tried your patch?  Results?

	Robert Love

