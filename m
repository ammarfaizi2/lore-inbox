Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbUAJL2D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 06:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUAJL2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 06:28:03 -0500
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:25047 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S265069AbUAJL1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 06:27:53 -0500
From: Rob <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: ivern@acm.org
Subject: Re: Make the init-process look like the StarWars Credits
Date: Sat, 10 Jan 2004 06:26:17 -0500
User-Agent: KMail/1.5.4
References: <3FFEDD1D.7000003@ippensen.de> <200401092107.13588.rpc@cafe4111.org> <3FFFDBDF.4090900@acm.org>
In-Reply-To: <3FFFDBDF.4090900@acm.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401100626.17775.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 06:02 am, you wrote:

> I think you're overcomplicating the issue.  You certainly don't need any
> 3D code to get a star-wars like scroll going.  You can make a 2D
> transform to make the fonts _look_ like they're scrolling out into
> space.  As a matter of fact, wouldn't simply transforming the
> rectangular viewport into a trapezoid do the trick?  You could then
> frame this with a starry bitmap, or whatever.
>
> This doesn't sound like it would require any massive hacking (although
> I'll readily confess that I haven't looked into the code.)

i know,  i'm a pessimist seeing things way too negatively. not trying to knock 
a guy senseless for his 3d suggestion, i just got carried away. sorry...

of course you wouldn't _need_ actual 3D code, so you can leave mesa out. it's 
just the issue of HW accel vs. software making things really hard to do 
without engineering a new DRI-like fb, it seems. and that new fb has other 
(ab)uses... one thing leads to another.

and what youre describing... that's quite like the hacked fb fullscreen splash 
code i'm suggesting. but i'm not realizing that a little code can draw a lot 
of things. thus it probably _could_ all fit in the kernel (except gfx) and 
run instantly (but only unitl init is through booting to the default 
runlevel, i hope?)

-- 
Rob Couto
rpc@cafe4111.org
Rules for computing success:
1) Attitude is no substitute for competence.
2) Ease of use is no substitute for power.
3) Safety matters; use a static-free hammer.
--

