Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUAIRYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbUAIRYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:24:25 -0500
Received: from ms-smtp-01-smtplb.ohiordc.rr.com ([65.24.5.135]:52668 "EHLO
	ms-smtp-01-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S262848AbUAIRYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:24:23 -0500
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: Make the init-process look like the StarWars Credits
Date: Fri, 9 Jan 2004 12:18:12 -0500
User-Agent: KMail/1.5.4
References: <3FFEDD1D.7000003@ippensen.de>
In-Reply-To: <3FFEDD1D.7000003@ippensen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401091218.12671.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 January 2004 11:55, Niels Ippensen wrote:
> Hi,
>
> I was wondering if there is a way to make the boot-process look
> StarWars-like:
>
>
>    		lalallaal
>   	llalalallalalalalalalalalala
> lalalalalalalaalallalalalalalalalallala
>
> and let it scroll up the screen. I would think that this could be done
> with the Framebuffer-Device. Maybe something like fblogo or so.
>
> Thanks,
> Niels


if your processor is so fast that it gets bored waiting for your disk, that 
could be cool ;)

http://www.bootsplash.org has the utils for full-screen fb logo and other 
stuff, i.e. fbmngplay and fbtruetype, playback mng anims and drop text in any 
size/color/position on the screen in a TrueType font. mix that together with 
some nice bilinear filtering and you'd have the beginning of a jaw-dropping 
misuse of CPU :)

so in other words, without examining the practicality, yes. the fb can do that 
if the kernel console that gets rendered to the fb can be piped thru a gimpy 
pre-processor. sounds like fun. maybe one could even borrow the code from the 
starwars XScreenSaver to do the pretty rendering, since it already takes 
plaintext input.

-- 
Rob Couto
rpc@cafe4111.org
Rules for computing success:
1) Attitude is no substitute for competence.
2) Ease of use is no substitute for power.
3) Safety matters; use a static-free hammer.
--
