Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263501AbRFFP7I>; Wed, 6 Jun 2001 11:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263502AbRFFP66>; Wed, 6 Jun 2001 11:58:58 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:31515 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S263501AbRFFP6w>;
	Wed, 6 Jun 2001 11:58:52 -0400
Message-ID: <3B1E5316.F4B10172@illusionary.com>
Date: Wed, 06 Jun 2001 11:58:14 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Alvord <jalvo@mbay.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com> <3b204fe5.4014698@mail.mbay.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord wrote:
> 
> On Wed, 06 Jun 2001 11:31:28 -0400, Derek Glidden
> <dglidden@illusionary.com> wrote:
> 
> >
> >I'm beginning to be amazed at the Linux VM hackers' attitudes regarding
> >this problem.  I expect this sort of behaviour from academics - ignoring
> >real actual problems being reported by real actual people really and
> >actually experiencing and reporting them because "technically" or
> >"theoretically" they "shouldn't be an issue" or because "the "literature
> >[documentation] says otherwise - but not from this group.
> 
> There have been multiple comments that a fix for the problem is
> forthcoming. Is there some reason you have to keep talking about it?

Because there have been many more comments that "The rule for 2.4 is
'swap == 2*RAM' and that's the way it is" and "disk space is cheap -
just add more" than there have been "this is going to be fixed" which is
extremely discouraging and doesn't instill me with all sorts of
confidence that this problem is being taken seriously.

Or are you saying that if someone is unhappy with a particular
situation, they should just keep their mouth shut and accept it?

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
