Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWCJC5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWCJC5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWCJC5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:57:54 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:41355 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750784AbWCJC5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:57:53 -0500
Message-ID: <4410EAFF.9050509@cfl.rr.com>
Date: Thu, 09 Mar 2006 21:57:03 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Dave Neuer <mr.fred.smoothie@pobox.com>
CC: Luke-Jr <luke@dashjr.org>, Anshuman Gholap <anshu.pg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>  <200603091509.06173.luke@dashjr.org> <441057D4.6030304@cfl.rr.com>  <161717d50603090933o3df190f9vb1e06b0ec37deb8e@mail.gmail.com>  <44108CCB.9080709@cfl.rr.com> <161717d50603091330j61850529xcd50382a55ccb6b3@mail.gmail.com>
In-Reply-To: <161717d50603091330j61850529xcd50382a55ccb6b3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Neuer wrote:
> A "work based on one or more preexisting works [in] any other form in
> which a work may be recast, transformed or adapted" sure sounds like
> it fits someone compiling software with my symbols in it to me.
> Elaboration sure sounds like it fits program code calling my program
> code to me.
> 

No, because the individual names of functions are not covered by the 
copyright, only the body as a whole ( or significant part ).  That's why 
the first person to write hello.c can't sue everyone who uses printf().

>> You _might_ be able to
>> argue that they use your headers to compile their driver, so that
>> violates your copyright, but they are free to develop their own
>> compatible headers to produce compatible binaries which are in no way
>> derived from the Linux kernel.  See Wine's win32 compatible headers and
>> libraries for examples of this.
> 
> I'm sorry, I don't think that analysis is correct for software, see
> for example: http://community.linux.com/article.pl?sid=02/11/13/117247&tid=87&tid=41&tid=12&tid=42,
> and Linus' previous explanations as I pointed out in my reply to
> Xavier.
> 

The key question is does work A contain substantial parts of work B?  In 
the case of a source library that is compiled and linked into an 
executable, then you can argue that the executable image is a work 
substantially derived from the library.  In the case of linking to a 
shared object however, the binary does not actually contain any of the 
material from the library, so it is not a derived work.

This is why gcc is not infringing on Microsoft's copyrights whenever 
they create a win32 executable image that links to windows' dlls and 
this is why ndiswan and captive NTFS are not infringing on MS's 
copyrights.

In the case of wine, it is not infringing on Microsoft's copyright 
because they wrote their own win32 api headers.  They contain the same 
function names, but that does not make them a derived work.

In the case of ATI's drivers at least, they distribute their own object 
files which they hold the copyright to, and are not derived from the 
linux kernel in any way, and the user must link them with the correct 
objects of kernel code to create the actual loadable module.  At best if 
you could show that the final module contains substantial code from the 
kernel you might argue that it is a derived work, but since ATI only 
distributes their own object code, there's no way you can claim they are 
infringing on your copyright.


