Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314554AbSEFQZa>; Mon, 6 May 2002 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314558AbSEFQZ3>; Mon, 6 May 2002 12:25:29 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:3092 "EHLO
	tsmtp9.mail.isp") by vger.kernel.org with ESMTP id <S314554AbSEFQZ2>;
	Mon, 6 May 2002 12:25:28 -0400
Date: Mon, 6 May 2002 18:28:24 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: Justin Piszcz <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux & X11 & IRQ Interrupts
Message-Id: <20020506182824.7e234644.DiegoCG@teleline.es>
In-Reply-To: <3CD5D57D.DED89DFC@starband.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2002 20:59:41 -0400
Justin Piszcz <war@starband.net> escribió:

> When I move the mouse under X11 I hear a buzzing sound in the computer,
> first, I found it was the console speaker.
I have the same problem. I've heard this in windows 9X with some programs wich just do what linux does, to cool the cpu.

I've tried a program wich just does:
main(){
	do{
	}while(1);
}

with the highest priority. (nice --19 ./cpu_sound). CPU time is 100% used,
 but the noise _doesn't_ disappears.
I suspect it's just that I've a cheap power supply, and a Cyrix 6x86MX processor....


> 
> Yet, I still hear a very faint sound when I move the mouse cursor, this
> is after I've disconnected the console speaker, no matter what the rate
> of interrupts.
> 
> from itop:
> 
> INT                NAME          RATE             MAX
>   0 [             timer]   101 Ints/s     (max:   101)
>   1 [          keyboard]     1 Ints/s     (max:     1)
>   5 [              eth0]     2 Ints/s     (max:     4)
>  12 [        PS/2 Mouse]   276 Ints/s     (max:   276)
> 
> Other people have also reported this problem but there hasn't been an
> apparent fix for it yet?
> 
> With the console speaker attached, it can be clearly heard, as well as
> performing fast packet movements (nmap (with insane option)) or such you
> can literally hear the packets.
> 
> When I am compiling an application or spending interrupts on disk
> access (copying files/doing a find), moving the mouse/holding a key on
> the keyboard does not make noise.
> 
> Does anyone know the source of this problem, and possibly a solution, or
> something one can do to mute this annoying noise?
> 
> This noise does not occur in any version of MS windows, so I am curious
> as to what the kernel? or x11? is doing to produce this noise?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
