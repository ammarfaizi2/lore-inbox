Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUAISlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUAISlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:41:37 -0500
Received: from main.gmane.org ([80.91.224.249]:34221 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263107AbUAISj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:39:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Make the init-process look like the StarWars Credits
Date: Fri, 09 Jan 2004 19:39:56 +0100
Message-ID: <yw1xisjlvudf.fsf@kth.se>
References: <3FFEDD1D.7000003@ippensen.de> <200401091218.12671.rpc@cafe4111.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:aFsl/TgNf3Wwd7tc7gklX1Md/WQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Couto <rpc@cafe4111.org> writes:

> On Friday 09 January 2004 11:55, Niels Ippensen wrote:
>> Hi,
>>
>> I was wondering if there is a way to make the boot-process look
>> StarWars-like:
>>
>>
>>    		lalallaal
>>   	llalalallalalalalalalalalala
>> lalalalalalalaalallalalalalalalalallala
>>
>> and let it scroll up the screen. I would think that this could be done
>> with the Framebuffer-Device. Maybe something like fblogo or so.
>>
>> Thanks,
>> Niels
>
> if your processor is so fast that it gets bored waiting for your disk, that 
> could be cool ;)
>
> http://www.bootsplash.org has the utils for full-screen fb logo and
> other stuff, i.e. fbmngplay and fbtruetype, playback mng anims and
> drop text in any size/color/position on the screen in a TrueType
> font. mix that together with some nice bilinear filtering and you'd
> have the beginning of a jaw-dropping misuse of CPU :)
>
> so in other words, without examining the practicality, yes. the fb
> can do that if the kernel console that gets rendered to the fb can
> be piped thru a gimpy pre-processor. sounds like fun. maybe one
> could even borrow the code from the starwars XScreenSaver to do the
> pretty rendering, since it already takes plaintext input.

I suppose it would be possible to use 3D features of the graphics
chip.  It would require a rather massive hacking in the fb driver, of
course.

-- 
Måns Rullgård
mru@kth.se

