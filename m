Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWJWRiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWJWRiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWJWRiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:38:05 -0400
Received: from smtp101.plus.mail.re2.yahoo.com ([206.190.53.26]:14521 "HELO
	smtp101.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932213AbWJWRiC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:38:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:Content-Transfer-Encoding;
  b=yT7vO2ClKKfROQyjJMfdhXxjjnGmqSSy362OZx56OPkq0a3mElKasEGowK8Z4nOUl+paYkgzLr9y1vZ4nL2Z4QLD0TyCVljZKw9sePYLElGyQwWOgVNO0bgI8u4FCZ/hYC2XrK9UaAGKyfgjJVOc6jtBxegflWTOrPJ61ElfIZg=  ;
Date: Mon, 23 Oct 2006 14:20:07 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       info-linux@geode.amd.com
Subject: Re: [PATCH] do not compile AMD Geode's hwcrypto driver as a module per default
Message-ID: <20061023122007.GA4979@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <20061021081745.GA6193@zmei.tnic> <1161602705.19388.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1161602705.19388.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 12:25:05PM +0100, Alan Cox wrote:
> Ar Sad, 2006-10-21 am 10:17 +0200, ysgrifennodd Borislav Petkov:
> > This one should be probably made dependent on some #define saying that the cpu
> > is an AMD and has the LX Geode crypto hardware built in. Turn it off for now.
> 
> That makes no real sense. Most kernel selections are "run on lots of
> processor types", we thus want as much as possible modular, built and
> available.
> 
> The existing defaults seem quite sane.

... should the duration of the the kernel compilation be prolonged then by 
unneeded modules? Does the majority of people really use that crypto hardware or
is it a small percentage only, we don't know but it also doesn't seem pretty sensible to do
'make oldconfig' and go and turn off all modules that I don't need/have by hand;
it gets quite annoying sometimes too.

-- 
Regards/Gruß,
    Boris.

	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de
