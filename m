Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264191AbRFFV6u>; Wed, 6 Jun 2001 17:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264194AbRFFV6l>; Wed, 6 Jun 2001 17:58:41 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:4121 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S264190AbRFFV63>;
	Wed, 6 Jun 2001 17:58:29 -0400
Message-ID: <3B1EA75B.8AC19AA0@illusionary.com>
Date: Wed, 06 Jun 2001 17:57:47 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <E157kt7-0000Td-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I'm beginning to be amazed at the Linux VM hackers' attitudes regarding
> > this problem.  I expect this sort of behaviour from academics - ignoring
> > real actual problems being reported by real actual people really and
> 
> Actually I find your attitude amazing. If you would like a quote on fixing
> specific VM problems Im sure several people will be happy to tender.

The very first thing I said in my very first message on this topic is
that I've been following LKML for a couple of weeks now and following
the VM work.  I _know_ there are VM problems.  I _know_ there are people
working on the problems.  Yet, when I post a specific example, with
_clear and simple_ instructions on how to reproduce a problem I'm
experiencing and an offer to do whatever I can to help fix the problem,
I am told repeatedly, in effect "you need more swap, that's your
problem" (which isn't really even related to the issue I reported) by
names I have come to recognize and respect despite my status as not a
kernel hacker. Why shouldn't I be flabbergasted by that?

> I guess the patch to fix this that I have in my mailbox to merge doesnt exist.
> A pity because if it doesnt exist I cant send it to you

huh ... I just don't know how to take that except it seems to uphold
everything I said to which you responded so intensely.

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
