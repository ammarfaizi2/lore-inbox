Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280680AbRKFXVT>; Tue, 6 Nov 2001 18:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280688AbRKFXVJ>; Tue, 6 Nov 2001 18:21:09 -0500
Received: from [195.63.194.11] ([195.63.194.11]:1801 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S280680AbRKFXUv>;
	Tue, 6 Nov 2001 18:20:51 -0500
Message-ID: <3BE87CB9.43427FCF@evision-ventures.com>
Date: Wed, 07 Nov 2001 01:13:45 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ricky Beam <jfbeam@bluetopia.net>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <Pine.GSO.4.33.0111061611080.17287-100000@sweetums.bluetronic.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:

> And for those misguided people who think processing text is faster than
> binary, you're idiots.  The values start out as binary, get converted to
> text, copied to the user, and then converted back to binary.  How the hell
> is that faster than copying the original binary value? (Answer: it isn't.)

And then converted back to ASCII for printout on the terminal ;-).
 
> And those who *will* complain that binary structures are hard to work with,
> (you're idiots too :-)) a struct is far easier to deal with than text
> processing, esp. for anyone who knows what they are doing.  Yes, changes
> to the struct do tend to break applications, but the same thing happens
> to text based inputs as well.  Perhaps some of you will remember the stink
> that arose when the layout of /proc/meminfo changed (and broke, basically,
> everything.)

Amen.

The true problem with /proc and user land applications is that around 6
years
ago people did just give up on adapting the parsers to the ever chaning
"wonderfull" ascii interfaces those times. The second problem is that
/proc
is one of the few design "inventions" in linux, which didn't get copied
over
from some other UNIX box and Linus doesn't wan't recognize that this was
A BAD DESIGN CHOICE.
