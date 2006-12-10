Return-Path: <linux-kernel-owner+w=401wt.eu-S1759472AbWLJC3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759472AbWLJC3x (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 21:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759616AbWLJC3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 21:29:53 -0500
Received: from web58306.mail.re3.yahoo.com ([68.142.236.159]:21202 "HELO
	web58306.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759472AbWLJC3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 21:29:52 -0500
Message-ID: <20061210022951.440.qmail@web58306.mail.re3.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=xavpqVQznmSpVeemW0hDBzN5iRoHGwhKjAG24ZsY3w0qp8P+KSdB+Y1hLQC4+W7MF1RllZuKAReqjQiqOHgeKJdK0ElCEg/M/FlhglsPLD3lQwjFmUiWajKZ8YTnVN7jwmt++icsKw3V9MfQNs8AZT3TlJaByK2OOKFe9yDOcd8=;
X-YMail-OSG: G8_AtQgVM1lJ2gMq9WXS1qF1FD22QQuE_ywEeXCs_LAkfl7FleXArRm54HPz.lno.A--
Date: Sat, 9 Dec 2006 18:29:51 -0800 (PST)
From: xu feng <xu_feng_xu@yahoo.com>
Subject: virtual cache, TLB, and OS
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I wish to be personally CC'ed the answers/comments
posted to the list in response to this post. 


I am confused about the following point regarding
Virtual Indexed Tag Indexed Cache and i would
appreciate any help

I have read in this article 
http://www.linuxjournal.com/article/7105 , the
following:
<< In virtually indexed, virtually tagged (VIVT)
caches...suffer from several other problems:
1- Virtual address translations usually are changed as
part of normal kernel operation, so the cache must pay
careful attention to changes in TLB entries (and
changes in address space) and flush cache lines whose
translations have changed.
2- Even in a single address space, multiple virtual
addresses may exist for the same physical address.
Each of these virtual addresses would be cached
separately, even though they represent the same data.
This is called the cache-line aliasing problem.
>>

I am just confused about the author:
1- first point, why the cache has to be bothered by
the change in the address logical-physical mapping
since it is a virtual cache??

2- could you please give me a situation where two
virtual addresses from the same process are mapped to
the same physical address? 

i can't see this happening since each process page is
allocated a dedicated frame. 

sorry if my questions seem obvious
thank you for your help










 
____________________________________________________________________________________
Any questions? Get answers on any topic at www.Answers.yahoo.com.  Try it now.
