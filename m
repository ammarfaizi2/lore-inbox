Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279705AbRJYEfg>; Thu, 25 Oct 2001 00:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279706AbRJYEfX>; Thu, 25 Oct 2001 00:35:23 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:32237 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S279705AbRJYEfE>; Thu, 25 Oct 2001 00:35:04 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Bill Davidsen <davidsen@prodigy.com>
Date: Thu, 25 Oct 2001 14:35:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15319.38517.663820.504760@notabene.cse.unsw.edu.au>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 cannot find root device on raid
In-Reply-To: message from Bill Davidsen on Tuesday October 23
In-Reply-To: <Pine.LNX.4.33.0110180755090.5641-100000@windmill.gghcwest.com>
	<3BD588CE.FBCB081E@prodigy.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 23, davidsen@prodigy.com wrote:
> 
> The line you provide doesn't look anything like the two forms in the
> md.txt you mention. Or rather it looks like a blending, but neither of
> them is md0= in form. I have to look at the code to see which is
> correct, possibly yours, since the 
>   append = "md=0,/dev/sda1,/dev/sdb1"
> line doesn't seem to work :-(

Odd ... I use lines just like that. e.g.:
   append="md=0,/dev/hda1,/dev/hde1,/dev/hdg1"

and it works just fine.  What do you get in the way of error messages?

NeilBrown
