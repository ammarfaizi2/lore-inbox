Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTD0Tp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 15:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTD0Tp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 15:45:27 -0400
Received: from birosca.ime.usp.br ([143.107.45.59]:49054 "HELO
	birosca.ime.usp.br") by vger.kernel.org with SMTP id S261631AbTD0TpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 15:45:25 -0400
Date: Sun, 27 Apr 2003 16:57:31 -0300
From: Livio Baldini Soares <livio@ime.usp.br>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Re:  Swap Compression
Message-ID: <20030427195731.GA5759@ime.usp.br>
Mail-Followup-To: Livio Baldini Soares <livio@ime.usp.br>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
References: <200304251848410590.00DEC185@smtp.comcast.net> <20030426091747.GD23757@wohnheim.fh-wedel.de> <200304261148590300.00CE9372@smtp.comcast.net> <20030426160920.GC21015@wohnheim.fh-wedel.de> <200304262224040410.031419FD@smtp.comcast.net> <20030427090418.GB6961@wohnheim.fh-wedel.de> <200304271324370750.01655617@smtp.comcast.net> <20030427175147.GA5174@wohnheim.fh-wedel.de> <200304271431250990.01A281C7@smtp.comcast.net> <20030427190444.GC5174@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030427190444.GC5174@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  Unfortunately, I've missed the  beginning of this discussion, but it
seems you're trying  to do almost exactly what  the "Compressed Cache"
project set out to do:

http://linuxcompressed.sourceforge.net/

  _Please_ take a  look at it. Rodrigo de Castro  (the author) spent a
_lot_ of time working out the issues and corner details which a system
like this entail. I've been also  involved in the project, even if not
actively  coding, but  giving suggestions  and helping  out  when time
permitted.   This   project  has  been   the  core  of   his  Master's
dissertation, which  he has just finished writting  recently, and will
soon defend.

  It would be foolish (IMHO) to start from scratch. Take a look at the
web site. There is a nice sketch of the degin he has chosen here:

http://linuxcompressed.sourceforge.net/design/

  Scott Kaplan, a researcher  interested in compression of memory, has
also helped a bit. This article is something definitely worth reading,
and was one of Rodrigo's "starting point":

http://www.cs.amherst.edu/~sfkaplan/papers/compressed-caching.ps.gz

  (There are other relevant sources available on the web page).

  Rodrigo has also written a  paper about his compressed caching which
has much  more up-to-date information  than the web page.   His newest
benchmarks  of  the  newest  compressed  cache  version  shows  better
improvements then the numbers on the web page too. I'll ask him to put
it somewhere public, if he's willing.

Jörn Engel writes:
> On Sun, 27 April 2003 14:31:25 -0400, rmoser wrote:

[...]

> Another thing: Did you look at the links John Bradford gave yet? It
> doesn't hurt to try something alone first, but once you have a good
> idea about what the problem is and how you would solve it, look for
> existing code.

  I think the compressed cache project is the one John mentioned.

> Most times, someone else already had the same idea and the same
> general solution. Good, less work. Sometimes you were stupid and the
> existing solution is much better. Good to know. And on very rare
> occasions, your solution is better, at least in some details.
> 
> Well, in this case, the sourceforge project appears to be silent since
> half a year or so, whatever that means.

  It means Rodrigo has been  busy writting his dissertation, and, most
recently, looking  for a job :-)  I've talked to him  recently, and he
intends to continue on with the project, as he might have some time to
devote to it.

  On a side  note, though, one thing that has  still not been explored
is compressed  _swap_. Since the project's focus  has been performance
gains, and it  was not clear from the  beginning that compressing swap
actually  results  in  performance   gains,  it  still  has  not  been
implemented. That said, this *is* on the project's to-study list. 


  Hope this helps,

--  
  Livio B. Soares
