Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131454AbRAXBOj>; Tue, 23 Jan 2001 20:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRAXBO3>; Tue, 23 Jan 2001 20:14:29 -0500
Received: from [203.169.151.222] ([203.169.151.222]:61705 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S131454AbRAXBOX>;
	Tue, 23 Jan 2001 20:14:23 -0500
Message-ID: <3A6E2C6E.632CDABF@coppice.org>
Date: Wed, 24 Jan 2001 09:14:22 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
In-Reply-To: <200101231600.LAA24562@mah21awu.cas.org> <3A6DB234.1090507@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately the C standards people don't seem to realise there are
languages other than English. C99 had perfect timing to introduce UTF8
Unicode as acceptable in C source. Alas they missed the boat. I have
been embedding Chinese in C source for years (mostly Big-5 -  UTF8 is
more likely to be troublesome with existing compilers), and have yet to
hit a significant problem. It isn't standards compliant, though.

Regards,
Steve


Joe deBlaquiere wrote:
> 
> Too bad we can't just do a "Prince" and invent unpronouncable symbols to
> use as function names... or perhaps just use something from the chinese
> fonts ;o)...
> 
> Mike Harrold wrote:
> 
> >> This message is in MIME format. Since your mail reader does not understand
> >> this format, some or all of this message may not be legible.
> >>
> >> ------_=_NextPart_001_01C08552.FFC336D0
> >> Content-Type: text/plain;
> >>      charset="ISO-8859-1"
> >>
> >> I prefer descriptive variable and function names - like comments, they help
> >> to make code so much easier to read.
> >>
> >> One thing I wonder though... why do people prefer 'some_function_name()'
> >> over 'SomeFunctionName()'?  I personally don't like the underscore character
> >> - it's an odd character to type when you're trying to get the name typed in,
> >> and the shifted character, I find, is easier to input.
> >>
> >
> >
> > For exactly the reverse of that reason. Typing capital letters is a heck
> > of a lot more difficult that addint an underscore.
> >
> > Then there is reasability.
> >
> >   void ThisIsMyDumbassFunctionName
> >
> > if MUCH more difficult to read than
> >
> >   void this_is_my_clear_and_easy_function_name
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
