Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWATR4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWATR4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWATR4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:56:42 -0500
Received: from free.wgops.com ([69.51.116.66]:50948 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751122AbWATR4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:56:41 -0500
Date: Fri, 20 Jan 2006 10:56:25 -0700
From: Michael Loftis <mloftis@wgops.com>
To: sean <seanlkml@sympatico.ca>
Cc: James@superbug.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Development tree, please?
Message-ID: <58FE66DF7131B93329558B01@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <BAYC1-PASMTP02748FE950A9EFB4BAB4CFAE1F0@CEZ.ICE>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 	<43D10FF8.8090805@superbug.co.uk>
 	<6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
 <BAYC1-PASMTP02748FE950A9EFB4BAB4CFAE1F0@CEZ.ICE>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I changed the please to a lower case, I was overly punchy in the subject 
line, and I apologize to everyone for that)

--On January 20, 2006 12:11:16 PM -0500 sean <seanlkml@sympatico.ca> wrote:

> On Fri, 20 Jan 2006 09:36:35 -0700
> Michael Loftis <mloftis@wgops.com> wrote:
>
>> Yes I realise this change isn't out of the blue or anything, but it's in
>> a  'stable' kernel.  Why bother calling 2.6 stable?  We may as well have
>> stayed at 2.5 if this sort of thing is going to continue to be pulled.
>>
>
> Most of your message seems to boil down to complaining that devfs has
> been removed. Unfortunately your frustration is pointed in the wrong
> direction; you should be asking yourself why you ignored all those
> warnings about devfs removal for so long. If you really need it, just use
> the 2.4 kernel; it's very stable.

It is.  And the majority of the systems I've built (and still most new 
installs) use 2.4, but because of the need in many situations for things 
that only existed starting in 2.5 there's more argument for many cases for 
2.6 (and with some of the ARM development I've got going on there's even 
more argument for 2.6...despite the headers playing games with me right 
now....)

> If you want to complain about the current tree being called "stable",
> then just don't call it stable.   Call it the development tree because in
> the end that's what  it is.  No need to get hung up on a name; it is what
> it is.  Anyone, is free to fork a real stable tree just like some
> distributions do.   But such "stable" trees just  aren't going to be
> maintained by the same people who develop the mainline; they have enough
> to do already.

I was under the impression that the consensus has usually been multiple 
forks dividing a lot of external development resources into their own 
little camps instead of letting them all contribute to the main kernel was 
considered a bad thing?  Has this changed?  I know it's better for the 
developers....but shouldn't they or...'someone' be responsible for 
maintenance and have a place to do so?  Community maintenance? 
Developer+maintainer pairs in cases where the developer is unable or 
unwilling to actually maintain his/her code?

A target for such efforts, and community support for them would continue 
the ... 'tradition' of this being a community kernel where efforts are 
focused, and not where efforts are turned away and told to maintain your 
own forks.

>
> If you can think of an idea to solve your problem without demanding that
> other people  (ie. the mainline developers) do extra work, then speak up.
> But just demanding that the developers patch a stable tree while working
> on the development branch as well, has other _real_ costs that
> precipitated the shift to the current model.

Having a stable tree would atleast give me a place to commit changes to 
publicly where/if I needed to.  My main concern *today* is the devfs 
problems which I can solve yes and were known about yes, but require quite 
a bit of effort just to support the second problem of *today* which is 
Intel's latest e1000 variant.  That though is just today's troubles right 
now.  I can see others coming, and I'm concerned.

I understand the reason, but the problem it creates is it does give a lot 
of places incentive to just not contribute their bugfixes, and instead fork 
since they're not interested in getting involved in API changes 'right now'.


