Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbRFGPuN>; Thu, 7 Jun 2001 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRFGPuD>; Thu, 7 Jun 2001 11:50:03 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:31750 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S261741AbRFGPty>;
	Thu, 7 Jun 2001 11:49:54 -0400
Message-ID: <3B1FA29B.812AA63A@illusionary.com>
Date: Thu, 07 Jun 2001 11:49:47 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106062032390.26171-100000@asdf.capslock.lan> <991883613.15447.0.camel@agate>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> So please, if you have new facts that you want to offer that
> will help us characterize and understand these VM issues better
> or discover new problems, feel free to share them.  But if you
> just want to rant, I, for one, would rather you didn't.

*sigh*

Not to prolong an already pointless thread, but that really was the
intent of my original message.  I had figured out a specific way, with
easy-to-follow steps, to make the VM misbehave under very certain
conditions.  I even offered to help figure out a solution in any way I
could, considering I'm not familiar with kernel code.

However, I guess this whole "too much swap" issue has a lot of people on
edge and immediately assumed I was talking about this subject, without
actually reading my original message.

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#!/usr/bin/perl -w
$_='while(read+STDIN,$_,2048){$a=29;$b=73;$c=142;$t=255;@t=map
{$_%16or$t^=$c^=($m=(11,10,116,100,11,122,20,100)[$_/16%8])&110;
$t^=(72,@z=(64,72,$a^=12*($_%16-2?0:$m&17)),$b^=$_%64?12:0,@z)
[$_%8]}(16..271);if((@a=unx"C*",$_)[20]&48){$h=5;$_=unxb24,join
"",@b=map{xB8,unxb8,chr($_^$a[--$h+84])}@ARGV;s/...$/1$&/;$d=
unxV,xb25,$_;$e=256|(ord$b[4])<<9|ord$b[3];$d=$d>>8^($f=$t&($d
>>12^$d>>4^$d^$d/8))<<17,$e=$e>>8^($t&($g=($q=$e>>14&7^$e)^$q*
8^$q<<6))<<9,$_=$t[$_]^(($h>>=8)+=$f+(~$g&$t))for@a[128..$#a]}
print+x"C*",@a}';s/x/pack+/g;eval 

usage: qrpff 153 2 8 105 225 < /mnt/dvd/VOB_FILENAME \
    | extract_mpeg2 | mpeg2dec - 

http://www.eff.org/                    http://www.opendvd.org/ 
         http://www.cs.cmu.edu/~dst/DeCSS/Gallery/
