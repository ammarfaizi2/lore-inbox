Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264162AbRFFVJc>; Wed, 6 Jun 2001 17:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264163AbRFFVJW>; Wed, 6 Jun 2001 17:09:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19219 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264162AbRFFVJJ>;
	Wed, 6 Jun 2001 17:09:09 -0400
Date: Wed, 6 Jun 2001 22:08:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010606220832.A31009@flint.arm.linux.org.uk>
In-Reply-To: <20010606182221.B30546@flint.arm.linux.org.uk> <Pine.LNX.4.10.10106061317180.12135-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106061317180.12135-100000@transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jun 06, 2001 at 01:20:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 01:20:53PM -0700, James Simmons wrote:
> Never noticed it until now. Very nice patch :-) I have to agree as well.
> It would be nice if we had 
> 
> 1) A seperate serial directory under drivers.
> 
> 2) A nice structure that input devices and the tty layer can use. It is
>    just a waste to go threw the tty layer for input devices. It would also
>    make serial driver writing easier if the api is designed right :-) 

I am planning some day (don't know when yet though) to convert the 16x50
driver over to the serial_core stuff.

NB, Ted Tytso mentioned something at the 2.5 conference about integrating
some of the serial layer with the tty layer.
--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

