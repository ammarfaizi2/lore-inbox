Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRCSQza>; Mon, 19 Mar 2001 11:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbRCSQzU>; Mon, 19 Mar 2001 11:55:20 -0500
Received: from ns.electricgod.net ([209.134.141.2]:41486 "EHLO
	wolverine.timelords.org") by vger.kernel.org with ESMTP
	id <S131505AbRCSQzN>; Mon, 19 Mar 2001 11:55:13 -0500
Date: Mon, 19 Mar 2001 10:50:36 -0600 (CST)
From: Joshua Jore <moomonk@wolverine.timelords.org>
To: Leandro Bernsmuller <leberns@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: floppy programming
In-Reply-To: <20010318160105.11345.qmail@web1302.mail.yahoo.com>
Message-ID: <Pine.BSF.4.33.0103191047510.81521-100000@wolverine.timelords.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually... that sounds like zone bit recording. As I understand it, that
sort of thing is handled by the floppy controller and isn't under the
purview of the OS. Anyhoo, what really got me on this, is I understand
there will be some new floppy drives out soon that'll do this sort of
thing by default. It allows ~33MB of data on a 1.44MB floppy. (let's just
forget how often disks bo bad here)

Pretty cool if can do it w/o changing the hardware.

Josh

___SIG___
$_='while(read+STDIN,$_,2048){$a=29;$b=73;$c=142;$t=255;@t=map{$_%16or$t^=$c^=(
$m=(11,10,116,100,11,122,20,100)[$_/16%8])&110;$t^=(72,@z=(64,72,$a^=12*($_%16
-2?0:$m&17)),$b^=$_%64?12:0,@z)[$_%8]}(16..271);if((@a=unx"C*",$_)[20]&48){$h
=5;$_=unxb24,join"",@b=map{xB8,unxb8,chr($_^$a[--$h+84])}@ARGV;s/...$/1$&/;$
d=unxV,xb25,$_;$e=256|(ord$b[4])<<9|ord$b[3];$d=$d>>8^($f=$t&($d>>12^$d>>4^
$d^$d/8))<<17,$e=$e>>8^($t&($g=($q=$e>>14&7^$e)^$q*8^$q<<6))<<9,$_=$t[$_]^
(($h>>=8)+=$f+(~$g&$t))for@a[128..$#a]}print+x"C*",@a}';s/x/pack+/g;eval

On Sun, 18 Mar 2001, Leandro Bernsmuller wrote:

>
> Hi,
>
> some body know if exist or is possible to do one
> driver
> to makes floppy drive use some type of "balanced" bits
> distribution?
> The idea is simple: format a disk doing inner tracks
> with less bits than
> in external tracks.
> Maybe is better think in sectors and not bits
> banlancing?
>
> I want opinions about the idea, pleace.
>
> Where can I find information about floppy drivers
> programming, DMA setup,...?
>
> Thanks,
>
> Leandro
>
> __________________________________________________
> Do You Yahoo!?
> Get email at your own domain with Yahoo! Mail.
> http://personal.mail.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

