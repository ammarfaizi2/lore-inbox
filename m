Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267168AbSKPAvW>; Fri, 15 Nov 2002 19:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267177AbSKPAvW>; Fri, 15 Nov 2002 19:51:22 -0500
Received: from zork.zork.net ([66.92.188.166]:31972 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S267168AbSKPAvV> convert rfc822-to-8bit;
	Fri, 15 Nov 2002 19:51:21 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Reserving "special" port numbers in the kernel ?
References: <1037405489.8019.10.camel@localhost>
	<uadkabais.fsf@unix-os.sc.intel.com>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: MISMATCHED PARENTHESES, NON-SEQUITUR
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 16 Nov 2002 00:58:17 +0000
In-Reply-To: <uadkabais.fsf@unix-os.sc.intel.com> (Arun Sharma's message of
 "15 Nov 2002 16:53:15 -0800")
Message-ID: <6uvg2y49g6.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Arun Sharma quotation:

> xavier.bestel@free.fr (Xavier Bestel) writes:
>
>> Le sam 16/11/2002 Ã  01:00, Arun Sharma a Ã©critÂ :
>> > One of the Intel server platforms has a magic port number (623) that
>> > it uses for remote server management. However, neither the kernel nor
>> > glibc are aware of this special port.
>> > 
>> > As a result, when someone requests a privileged port using
>> > bindresvport(3), they may get this port back and bad things happen.
>> > 
>> > Has anyone run into this or similar problems before ? Thoughts on
>> > what's the right place to handle this issue ?
>> 
>> run a dummy app at startup which reserves that port ?
>
> Yes, I'm already aware of this one, but was looking for a lighter weight
> solution (ideally a config file change) that doesn't involve running an
> extra process (think of doing this on a large number of machines).

inetd

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
