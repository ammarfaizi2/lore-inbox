Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbRESLsc>; Sat, 19 May 2001 07:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261773AbRESLsX>; Sat, 19 May 2001 07:48:23 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:17297 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261767AbRESLsH>; Sat, 19 May 2001 07:48:07 -0400
Message-ID: <3B065C78.C20BBCA@uow.edu.au>
Date: Sat, 19 May 2001 21:43:52 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: bcrl@redhat.com, torvalds@transmeta.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in 
 userspace
In-Reply-To: <UTC200105191109.NAA53719.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> Hmm. You know that I wrote this long ago?

Well, let's not get too hung up on the disk thing (yeah,
I started it...).

Ben's intent here is to *demonstrate* how argv-style
info can be passed into device nodes.  It seems neat,
and nice.

We can also make use of a strong argument parsing library
in the kernel - there are a great number of open-coded
string bashing functions which could be rationalised
and regularised.


So.  When am I going to be able to:

	open("/bin/ls,-l,/etc/passwd", O_RDONLY);

?
