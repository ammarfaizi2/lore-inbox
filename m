Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVJDEi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVJDEi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 00:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVJDEi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 00:38:56 -0400
Received: from web35508.mail.mud.yahoo.com ([66.163.179.132]:58039 "HELO
	web35508.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751182AbVJDEi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 00:38:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FC6TMF8AoQ+xvNj84m6Yi+Xczj0/dppC1MtQRMZK2/D6nygvMkzVY6jBWKXqj+hO43W40Kk6j4LBVS2p9HMfVf/X+d2v8lNffhjeCVcdtNjWs5OTyuSsd9Ra3h6UtA34GBxqvc5ikz1RNOqcQfAH3NjX63wyp04nn4FJTov+KYc=  ;
Message-ID: <20051004043855.31468.qmail@web35508.mail.mud.yahoo.com>
Date: Mon, 3 Oct 2005 21:38:55 -0700 (PDT)
From: Dan C Marinescu <dan_c_marinescu@yahoo.com>
Subject: Re: The price of SELinux (CPU)
To: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <434204F8.2030209@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try selinux=0, _if u feel that way :-)

about big o:

http://www.maththinking.com/boat/compsciBooksIndex.html

   daniel



--- John Richard Moser <nigelenki@comcast.net> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I've heard that SELinux has produced benchmarks such
> as 7% increased CPU
> load.  Is this true and current?  Is it dependent on
> policy?  What is
> the policy lookup complexity ( O(1), O(n),
> O(nlogn)...)?  Are there
> other places where a bottleneck may exist aside from
> gruffing with the
> policy?  Isn't the policy actually in xattrs so it's
> O(1)?  Where else
> would an overhead that big come from aside from a
> lookup in a table?
> 
> ....
> 
> Why is the sky blue?  Why do you have a mustach? 
> Why doesn't mommy have
> one?  Does she shave it?
> 
> At any rate, my personal end goal is a secure
> high-performance operating
> system, as user friendly as Ubuntu, Mandriva, or
> Win----.  To this end,
> I'm (still; a lot of you have seen me before)
> evaluating the performance
> hit of various user and kernel security enhancements
> like PaX,
> ProPolice, various OpenWall/GrSecurity niceness that
> needs to be divided
> out, and of course LSM/SELinux.  Also wondering
> about that PHKMalloc
> thing on openbsd; is it really all that, is it junk,
> how's it compare to
> the recent ptmalloc work, and can it run on Linux
> for direct benching .
> . . but that's off topic.
> 
> - --
> All content of all messages exchanged herein are
> left in the
> Public Domain, unless otherwise explicitly stated.
> 
>     Creative brains are a valuable, limited
> resource. They shouldn't be
>     wasted on re-inventing the wheel when there are
> so many fascinating
>     new problems waiting out there.
>                                                  --
> Eric Steven Raymond
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird -
> http://enigmail.mozdev.org
> 
>
iD8DBQFDQgT4hDd4aOud5P8RAoWBAJ0foEe4JcqDDlb7mMXQ6Z6FjCFjLACfdmJz
> +j2lCH7DpTlZK6zUztldEGI=
> =RzhA
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
