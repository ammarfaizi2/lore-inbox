Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312944AbSD2RgI>; Mon, 29 Apr 2002 13:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313311AbSD2RgH>; Mon, 29 Apr 2002 13:36:07 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:34336 "EHLO
	server0011.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S312944AbSD2RgG>; Mon, 29 Apr 2002 13:36:06 -0400
Date: Mon, 29 Apr 2002 18:43:31 +0100
From: Ian Molton <spyro@armlinux.org>
To: tomas szepe <kala@pinerecords.com>
Cc: alchemy@us.ibm.com, rml@tech9.net, alan@lxorguk.ukuu.org.uk,
        rthrapp@sbcglobal.net, linux-kernel@vger.kernel.org
Subject: Re: The tainted message
Message-Id: <20020429184331.3230f5ab.spyro@armlinux.org>
In-Reply-To: <20020429171516.GA25377@louise.pinerecords.com>
Organization: The dragon roost
X-Mailer: Sylpheed version 0.7.5cvs1 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tomas szepe Awoke this dragon, who will now respond:

>  > Warning: The module (%s) does not seem to have a compatible license.
>  >          Please contact the supplier of this module regarding any
>  >          problems, or reproduce the problem after rebooting without
>  >          ever loading this module.
>  > 
>  > shorter?
> 
>  I don't think you can strip the part about open-ness of the code --
>  it's an essential part of the explanation. And "any problems" might
>  be too broad.

Moreover, I think the 'compatible license thing doesnt fly.

the argument against CLOSE modules is that they make the _whole_package_
undebuggable.

if the source is available, no matter HOW crippling its license, the
package _IS_ debuggable.

thie warning should be:

Warning: Module %s is not open source, and as such, loading it will make
your kernel un-debuggable. Please do not submit bug reports from a kernel
with this module loaded, as they will be useless, and likely ignored.
