Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbTAFQPt>; Mon, 6 Jan 2003 11:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbTAFQPt>; Mon, 6 Jan 2003 11:15:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6545 "HELO
	mailhub.stusta.mhn.de") by vger.kernel.org with SMTP
	id <S267025AbTAFQPp>; Mon, 6 Jan 2003 11:15:45 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Wolfgang Walter <ml-linux-kernel@studentenwerk.mhn.de>
Organization: Studentenwerk =?iso-8859-1?q?M=FCnchen?=
To: David Schwartz <davids@webmaster.com>
Subject: Re: Why is Nvidia given GPL'd code to use in non-free drivers?
Date: Mon, 6 Jan 2003 17:24:21 +0100
User-Agent: KMail/1.4.3
Cc: <linux-kernel@vger.kernel.org>, <rms@gnu.org>
References: <20030105053556.AAA16557@shell.webmaster.com@whenever>
In-Reply-To: <20030105053556.AAA16557@shell.webmaster.com@whenever>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301061724.21596.ml-linux-kernel@studentenwerk.mhn.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 January 2003 06:35, David Schwartz wrote:
> On Sun, 5 Jan 2003 05:39:35 +0100, Wolfgang Walter wrote:
> >On Sunday 05 January 2003 01:17, David Schwartz wrote:
> >>On Sat, 04 Jan 2003 18:44:58 -0500, Richard Stallman wrote:

> 	Sounds like every shrink wrap agreement in the world. You already
> have the thing you want to license, the licensee simply refuses to
> grant you the rights to that thing you already have unless you agree
> to a license that you are not free to negotiate.
>

A shrink wrap agreement is something completely different.  You must 
differiate between using software and the exploitation right of the 
copyright-user.

Say you buy a book. Reading it ist usage. Destroing it is usage. But writing a 
book which contains part of this book is not using it. Lending it in public 
libraries is not usage. Making copies and distribute them is not usage.

You don't need a license from the author to use the book.

A shrink wrap license agreement (or EULA) tries to restrict your rights to USE 
your bought copy THOUGH you didn't bought it from the person who wants you to 
do so and AFTER you bought it. With the book-example: you may only read it by 
night and you are not allowed to speak bad of it.

In Germany these shrink wrap license agreement and EULAs are simply invalid. I 
don't need a license to use the software I bought. Even though I have to 
click on "I Accept" or "I Agree" - this means nothing as I have to, to 
install it, and I have to install it, to use it.

Of course copyright law is different from country to country but this so in 
most countries.

In Germany microsoft tried to inhibit that peoply sell there copy of windows 
bought with a new computer (based on there EULA which declared this copy as 
OEM and only valid together with this computer). They failed of course - 
there is no license-agreement between the owner of this windows-copy and 
microsoft. I didn't license the copy, I bought it and own it. And to own 
software is enough to use it. They can't restrrict unilaterally my right to 
use it.

If I now use the software-update of windows, things get different. Then I 
conclude a license agreement with them.

It is the same with a Red Hat CD. To use the software you don't need a 
license. They cannot restrcit you in your legal rights as a user.

Back to nvidia: if nvidea-drivers are derived work from the kernel I don't 
now. By itself probably not if they don't use kernel-code. Does a user commit 
a copyright infringement if he loads them as module? Probably not because it 
is using the software (the kernel can and does load this module, you don't 
need to modify it). Does the use infringe the GPL? Hmm, as long as he uses 
the kernel-binary he bought and this kernel provides the mechanism to load 
the module he don't need to accept the GPL.

If he has to modify the kernel to load the module, then of course he has to 
accept the GPL because modifing the kernel is not using it. And then the GPL 
may forbid him to do so.

You see what would be the way to effectivly forbid non GPL-modules by a user: 
a) force the user so he has to modify the kernel OR b) force a module writer 
to include copyrighted material.

Maybe it is enough that the loader-mechanism in user-space and that this tool 
is not part of the kernel to make it legally a modification of the kernel - 
but I doubt it. But kernel-developpers may check that the module includes a 
poetry they wrote and which is part of the kernel-code.

I see (you state that below) that you think that using header files in 
software-projects is not making a derived work from those header files but 
instead using them.

I don't know what a court will decide. But I think this does not hold for 
header files as it does not hold for runtime libraries etc.

But of course you can reverse engineer and write your ones. Reverse 
engineering is rather easy with open source.

> 	This is the same for use. If Microsoft wants to, they can impose any
> terms in the EULA that they want.
>

No - not in most countries, not in the EU. If you don't conclude an agreement 
which microsoft which most people don't do. You buy a computer with windows 
2000 - you don't have an agreement with microsoft and they can't unilaterally 
force you to do so by effectifly making the product unusuable.

This is even so in most states of USA.

> 	Microsoft doesn't try to argue that every document I write in
> Windows 2000 is a derived work. Photoshop doesn't argue that every
> image I create in photoshop is a derived work.
>

Hmm, does OpenOffice that? Does Gimp that? No, of course not.

> 	All you can do with a header file is include it in your own code.
> All you can do with photoshop is produce photoshop files. Adobe
> doesn't argue that photoshop-created images are derived works.

They do. If you use there cliparts-collection you may produce derived works 
(it depends on the clipart) and the you NEED the agreement of the 
copyright-owners.

If you produce a PDF an you include copies of fonts you NEED the permission of 
the copyright holders of those fonts (if the fonts are copyrighted).

> Stallman *does* argue that Linux binary modules are derived works.

I don't know if he does.

If the source code of binary-modules do not contain copyrighted material from 
the kernel they probably not derived works. Loading the module into the 
kernel by the user may produce a derived work. Putting kernel and modules 
together in a distribution may produce a derived work.

Using kernel header files to produce the binary is very probably making a 
derived work. But it would be rather hard to prove that - as it is so easy to 
reverse engineer open source software and write your own header files.

>
> 	To support the GPL's ability to regulate the distribution of derived
> works you would have to argue that Adobe's EULA could legitimately
> prohibit you from distributing images you create with photoshop. Far

A image produced with photoshop is not a derived work. It does not contain 
photoshop. If you use a nice picture they delivered with photoshop as base 
then of course you may need a license.

> smarter for advocates of freedom to argue that this is fair use and
> the argument that such works are derived is bullcrap.

Fair use is something different. Fair use is about exploitation right without 
permission of the copyright holder. I.e. you may cite a book in your book 
(but you may not print a whole page or so). Making a copy of a book for 
private use without permission of the copyright holder. (In Germany i.a. you 
pay for this right: on every copy-device as cd-burners, printers, and on 
memories like harddiscs, blank CDs, etc. there are fees). 

For software there is almost no fair use in the EU. I.e. the right for private 
copies does not exist. On the other habd there are other explicit rights, 
i.e. to decompilate software to see how it works.

> 	Yes, but this is *use*, which is what the GPL is *not* supposed to
> stop. How can you use photoshop except to create images with it? How
> can you use a header file except to include it in your own code. I

You can read it. You can use that knowledge to write your own.

A

#include "linux/blabla.h"

does not make your file a derived work as long as you do not distribute those 
files with your file.

The one who compiles it using the kernel header files makes a derived work - 
the binary is a derived work. But thats my opinion. You thinks that it is 
using them.


Greetings,

Wolfgang Walter

-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
EDV
Leopoldstraße 15
80802 München
Tel: +49 89 38196-276
Fax: +49 89 38196-144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
