Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbSJIOSh>; Wed, 9 Oct 2002 10:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261749AbSJIOSh>; Wed, 9 Oct 2002 10:18:37 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:48860 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261747AbSJIOSe>; Wed, 9 Oct 2002 10:18:34 -0400
Message-ID: <3DA43C3A.2060608@bigpond.com>
Date: Thu, 10 Oct 2002 00:24:58 +1000
From: Brendan J Simon <brendan.simon@bigpond.com>
Reply-To: brendan.simon@bigpond.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
References: <Pine.LNX.4.44.0210091243240.338-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roman Zippel wrote:

>>But the fact that xconfig depends on QT is going to make some people hate
>>it.
>>    
>>
>This should be rather easily fixable, but it has to be done by someone who
>is more familiar with whatever prefered toolkit. I'm familiar with QT and
>it's absolutely great to get quickly reasonable results, if someone wants
>something else I gladly will help, but I can't do it myself.
>The interface to the back end is quite simple so it should be no real
>problem to add a different user interface.
>

This is a difficult one.  GUI's toolkits are a bit of religion 
(fundamentalist types too).

I like and use GNOME.  KDE looks good too but I steered away from it in 
the early days due to the Qt licensing.  I've heard rumors that the new 
license is GPL compatible but I get the feeling that it is still not 
squeeky clean.  A lot of people don't like the larger resources for 
these desktop environments.

The most common GUI toolkits used in Linux would be GTK, Qt, 
Lesstif/Motif and Xaw (I've probably missed some).  Xaw will work on 
just about every platform I think, not sure about the others on non 
linux platforms apart from lesstiff.

I personally believe in cross platform GUI toolkits and use wxWindows 
for this.  I really like wxpython (GTK and MSW only) for quick 
development.  I believe there are python wrappers to most toolkits (Qt, 
GTK, etc).

As you can see there are soooooo many guis to choose/use and everyone 
has there favourite.  I suggest that the real work be done outside of 
the GUI program.  ie. seperate GUI and application guts as much as 
possible.  I would use python as the main language but C or even C++ 
could be used instead as a lot of people hate interpreters, or hate 
python (prefer perl, php or something else).

I'm pretty sure there is no one solution and it comes down to the 
politics and preferences of the final decision makers up the heirarchy.

Good luck,
Brendan Simon.


