Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267465AbRGLKQy>; Thu, 12 Jul 2001 06:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbRGLKQo>; Thu, 12 Jul 2001 06:16:44 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14858 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267465AbRGLKQe>; Thu, 12 Jul 2001 06:16:34 -0400
Message-ID: <3B4D78E7.24CF2660@idb.hist.no>
Date: Thu, 12 Jul 2001 12:16:07 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "C. Slater" <cslater@wcnet.org>, linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <NOEJJDACGOHCKNCOGFOMOEKECGAA.davids@webmaster.com> <001501c10980$f42035a0$fe00000a@cslater> <3B4C180E.D3AE1960@idb.hist.no> <005f01c10a20$03baf5a0$fe00000a@cslater>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"C. Slater" wrote:
> 
> Unless we find some other way to do it, i think we will have to limit this
> to only switching between kernels with the same minor version. We probably
> would not beable to swap between 2.4 and 2.6 anyways, though it depends on
> what changes are made.

Minor versions won't help you.  Different minor versions try to stay
interface-compatible with each other.  But data structures not
exposed to interfaces can still be rewritten completely.

Lots of nice ideas and implementations have piled up for 2.5.  Those
who proves immensely successfull in 2.5 may get backported to 2.4
once they get enough testing.  Try reading a few months worth of
kernel patches and you'll see that things change in stable kernels
too.

Helge Hafting
