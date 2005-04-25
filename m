Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVDYRNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVDYRNj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVDYRNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:13:38 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:10733 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262635AbVDYQ7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:59:55 -0400
Message-ID: <426D21FE.3040401@tiscali.de>
Date: Mon, 25 Apr 2005 18:59:42 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
> 
>>The "git" didn't try store small variables, which aren't referenced, in 
>>the processor registers. It also didn't use the size_t type. I corrected 
>>a C++ style comment too.
> 
> 
> What kind of ancient C standard are you working against?
> 
> // isn't "C++" any more, and "register" variables are sooo 60's, man.
> 
> Pass the toke,
> 
> 		Linus
> 
"register" and "auto" variables aren't relicts of the 60's,  they're a 
part of the ISO-C 99 standard, I'm following, "man".

And if you think "register" variables are outdated, please remove the 
CONFIG_REGPARM option from the Kernel source.

Removing a "//" comment makes sense in this case because a "//" comment 
between hundrets of "/* */" comments looks extremly ugly and shows that 
the source is "patchworked" and unstructured.

Today a lot of people forget about the basic rules of coding. You too. :)

Matthias-Christian Ott

Literature:
[1] Dr.-Ing. Ludwig Claﬂen, Dipl.-Math. Ulrich Oefler: Unix und C: Ein 
Anwenderbuch; VEB Verlag Technik Berlin; 1990
[2] Erik de Castro Lopo, Peter Aitken, Bradley L. Jones: Teach Yourself 
C for Linux Programming in 21 Days; SAMS Publishing; 1999

