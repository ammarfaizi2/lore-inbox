Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUAJLDI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 06:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAJLDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 06:03:08 -0500
Received: from rs9.luxsci.com ([66.216.98.59]:13966 "EHLO rs9.luxsci.com")
	by vger.kernel.org with ESMTP id S265056AbUAJLDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 06:03:05 -0500
Message-ID: <3FFFDBDF.4090900@acm.org>
Date: Sat, 10 Jan 2004 03:02:55 -0800
From: Javier Fernandez-Ivern <ivern@acm.org>
Reply-To: ivern@acm.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rpc@cafe4111.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Make the init-process look like the StarWars Credits
References: <3FFEDD1D.7000003@ippensen.de> <200401091218.12671.rpc@cafe4111.org> <yw1xisjlvudf.fsf@kth.se> <200401092107.13588.rpc@cafe4111.org>
In-Reply-To: <200401092107.13588.rpc@cafe4111.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Couto wrote:

> AFAICT, that would be both excellent and terrible at the same time. using hw 
> accel makes the process lighter on CPU and looks great but ridiculously 
> intense on the coder... i mean, who could you recruit to take X11 vid drivers 
> and mutate them into kernel code? you'd need 3D code that belongs to Mesa, 
> DRI code that belongs to whatever X module and the matching kernel module, 
> possibly agpgart, and so on. by the time it's 3D, you aren't using the 
> framebuffer code, you've taken the GUI and moved it into the kernel --- hello 
> Win32. That's if you did it smart and made it modular enough to have other 
> purposes, i.e. X11 overdrive... then X needs to know about it, or at least 
> the DRI module involved, and then it's either they trip over one another or X 
> gets cut down to just the libs and network activity. then maybe the kernel 
> begins with X which starts your xterms fullscreen on vt1-6. all the time it's 
> faster and loads sooner. and along with it, you get the legendary stability 
> of a MS slop'erating system. to have that much for one brief piece of 
> eyecandy is a little silly. and when the booting's done, is vt1 still zooming 
> out into space? will I be able to see the top few lines of 'top'? 

I think you're overcomplicating the issue.  You certainly don't need any 
3D code to get a star-wars like scroll going.  You can make a 2D 
transform to make the fonts _look_ like they're scrolling out into 
space.  As a matter of fact, wouldn't simply transforming the 
rectangular viewport into a trapezoid do the trick?  You could then 
frame this with a starry bitmap, or whatever.

This doesn't sound like it would require any massive hacking (although 
I'll readily confess that I haven't looked into the code.)

-- 
Javier Fernandez-Ivern
