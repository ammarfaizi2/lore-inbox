Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSCSTjI>; Tue, 19 Mar 2002 14:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292178AbSCSTiw>; Tue, 19 Mar 2002 14:38:52 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:10757 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291948AbSCSTiD>; Tue, 19 Mar 2002 14:38:03 -0500
Message-ID: <3C97911B.BA27170E@linux-m68k.org>
Date: Tue, 19 Mar 2002 20:27:23 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander.Riesen@synopsys.com
CC: linux-kernel@vger.kernel.org
Subject: Re: alternative linux configurator prototype v0.2
In-Reply-To: <3C9396F5.7319AB27@linux-m68k.org> <3C94948E.777B5BAF@linux-m68k.org> <20020319150538.B1350@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alex Riesen wrote:

> I would appreciate somewhat more readability, though. It's not very
> simple to figure out in which state an option is (Y/N/M) if it's not focused.
> Maybe put the selected variant before the option name:
> + Networking options
>   + Packet socket
>   | <M> Netlink device emulation
>   | <N> Network packet filtering ...

Hmm, looks good, the current version has the advantage, that one sees
the available input range, but that's probably only important for
debugging.
So far I want to keep it simple, it should be just enough for people to
play with and for me to experiment with some ideas. Anything more fancy
has to wait.

> Besides, i think your selection of qt as gui platform is not making you
> many friends, though greatly speeded up the development.

"And I personally refuse to use inferior tools because of ideology." :)
It's not the first time I hear this, I'd really like to know where this
is coming from. I don't mind if someone implements the ui with another
toolkit, I'd actually be happy about this, as the ui part is more of a
burden for me, but until then I keep things simple for myself.

bye, Roman
