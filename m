Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281393AbRKMBA7>; Mon, 12 Nov 2001 20:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281355AbRKMBAu>; Mon, 12 Nov 2001 20:00:50 -0500
Received: from AGrenoble-101-1-4-53.abo.wanadoo.fr ([217.128.202.53]:31616
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281393AbRKMBAi> convert rfc822-to-8bit; Mon, 12 Nov 2001 20:00:38 -0500
Message-ID: <3BF07147.5050503@wanadoo.fr>
Date: Tue, 13 Nov 2001 02:03:03 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Sean Elble <S_Elble@yahoo.com>
Cc: joeja@mindspring.com, John Alvord <jalvo@mbay.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Testing Kernel Releases Before Being Released (Was Re: Re: loop back broken in 2.2.14)
In-Reply-To: <Springmail.105.1005596822.0.40719200@www.springmail.com> <00c701c16bd2$e4b11800$0a00a8c0@intranet.mp3s.com> <3BF06B44.1040709@wanadoo.fr> <015101c16bdc$e633dbe0$0a00a8c0@intranet.mp3s.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am wondering too... Anyone got ideas on this ?

I would like to avoid some specific problems... especially
bugs that show up when compiling a certain module / feature
of the kernel, like the loopback in 2.4.14.

Those should be very easy to get rid of
[it only takes some kernel testers to debug that early, if only
there actually were a feature freeze that last for one day...].

François


Sean Elble wrote:

> Can't argue with you on the respect that kernels should be tested, but I
> _can_ argue with you on your method. :-) The main problem that I see there
> is that you are then limiting yourself (well not you, but just making things
> hypothetical) to a certain number of test kernels. What if another problem
> is found after the freeze? Testing should be done any time Linus gets ready
> to release a kernel, though a feature freeze wouldn't be a bad idea. I'm
> still wondering what the best solution is though . . .
> 
> -----------------------------------------------
> Sean P. Elble
> Editor, Writer, Co-Webmaster
> ReactiveLinux.com (Formerly MaximumLinux.org)
> http://www.reactivelinux.com/
> elbles@reactivelinux.com
> -----------------------------------------------
> 
> ----- Original Message -----
> From: "François Cami" <stilgar2k@wanadoo.fr>
> To: "Sean Elble" <S_Elble@yahoo.com>
> Cc: <joeja@mindspring.com>; "John Alvord" <jalvo@mbay.net>;
> <linux-kernel@vger.kernel.org>
> Sent: Monday, November 12, 2001 7:37 PM
> Subject: Re: Testing Kernel Releases Before Being Released (Was Re: Re: loop
> back broken in 2.2.14)
> 
> 
> 
> I guess the way I'd do it would be to actually freeze [in which I mean
> no more 'testing' patch are applied] a pre something, say 2.4.XpreY for
> example, see if there are any obvious bugs in it (like the loopback in
> 2.4.14), correct them, test again, and if it's okay,
> release 2.4.X.
> 
> Of course, I've never done much kernel work except testing, so I'm not
> exactly the one who should talk about it.
> 
> Still, I think that from the user point of view (and there was a post in
> LKML yesterday, about Linux being used by UN*X experienced sysadmins
> only... or going mainstream instead) the releases should be tested a bit
> more thoroughly and actually *frozen* for some time (a day or two should
> suffice I guess) before being labelled 2.4.X.
> 
> Just the two cents from a newbie - I hope/mean to offense noone with that
> 
> François Cami
> 
> 
> 
> Sean Elble wrote:
> 
> 
>>Something definitely should be done to help "stabilize" the tree; it's not
>>really a big deal for most of us if something is broken, as you know there
>>will be a fix posted very soon after the release, _but_ bugs like these
>>don't exactly make Linux "look good" to the rest of the UNIX community. A
>>FreeBSD advocate might say "well, FreeBSD never does _that_". My
>>
> suggestion
> 
>>to help fix the problem would be to do what SGI does; have two seperate
>>trees that strive to stay as close to each other as possible, but one
>>becomes part of the "maintaince stream", where only bug fixes and the such
>>are added, and a "features stream", where actual new features are added
>>
> in.
> 
>>Take a look at some of the IRIX web pages at http://www.sgi.com/ for a
>>better idea of how that works, but believe me, it works. This would be in
>>addition to some sort of testing suite that each official kernel must pass
>>before it is released. With the growing number of (important/big) Linux
>>users, we must make sure each kernel is rock-solid before being released.
>>This is definitely more of a political topic than a technical one, but it
>>has to be addressed nonetheless.
>>
>>-----------------------------------------------
>>Sean P. Elble
>>Editor, Writer, Co-Webmaster
>>ReactiveLinux.com (Formerly MaximumLinux.org)
>>http://www.reactivelinux.com/
>>elbles@reactivelinux.com
>>-----------------------------------------------
>>



