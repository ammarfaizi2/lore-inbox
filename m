Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbSJWUa3>; Wed, 23 Oct 2002 16:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbSJWUa3>; Wed, 23 Oct 2002 16:30:29 -0400
Received: from pc132.utati.net ([216.143.22.132]:28033 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S265194AbSJWUa0> convert rfc822-to-8bit; Wed, 23 Oct 2002 16:30:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: nwourms@netscape.net, linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
Date: Wed, 23 Oct 2002 10:36:33 -0500
User-Agent: KMail/1.4.3
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB4BD8F.1010707@pobox.com> <ap420c$m3v$1@main.gmane.org>
In-Reply-To: <ap420c$m3v$1@main.gmane.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210222139.32805.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 12:32, Nicholas Wourms wrote:

> As was stated by Dave Jones[1], this is something that will probably should
> go in after the freeze.

This is just a thought, and it's from somebody who's not going to actually be 
making any of these decisions, but my idea of "goes in after the freeze" is 
the same as my idea of "goes in during the stable series".

If you'd be happy including something between stable.0 and stable.1, or 
stable.5 and stable.6, (whether "stable" is called "2.6", "3.0", or "fred") 
then it makes sense to put it in after the freeze.  But if you don't think it 
would be a good idea to insert it after stable.0, then inserting it after the 
freeze at all is a bit hypocritical.  (Otherwise the freeze isn't too 
meaningful.)

Now, given that, if it could go in during the stable series, why not wait 
until then and not confuse the issue during stabilization and shutdown of the 
-pre series?  (Or at least hold off until closer to dot-0 release date, and 
give the existing infrastructure a chance to settle down a bit first.  At the 
very least not rush to get too much in immediately after the freeze.)

Admittedly the first dozen releases of 2.4 are a bad example of "stable", but 
reiserfs did go in circa 2.4.1 and nobody really minded that bit.  Maybe LVM 
and EVMS are similar, self contained, can't possibly hurt anybody who isn't 
using it type things.  (I don't know.  The word "maybe" is an important 
weasel word in that sentence.)

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?


