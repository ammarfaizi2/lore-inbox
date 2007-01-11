Return-Path: <linux-kernel-owner+w=401wt.eu-S965344AbXAKJXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965344AbXAKJXz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 04:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbXAKJXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 04:23:54 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:38276 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965344AbXAKJXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 04:23:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hb7eIjnCNTRhfvBarDnPe8ugJs4JH6gyvYsCNYZ6JvWVYA/vbl3+TNrgB+5o1Gai5YLEzULxgeqmo13fjBySeWR85NXEDik36X1Kdkqxg1D9Cq0B4wGBLm+xs5/Q8r6mFkFGgHARUBZyvvWIf45UN4OsDR3qkyGLJ8rXGibJ9YI=  ;
X-YMail-OSG: ot9_SLIVM1kC.ybQwqUUqJLE1DYlZwohGVqp30oOnr77IKkC8H.GzmUPRc_ubqNoBFk89QX_Qz2uWmPpFspGCEg5l0EBDxHar1LpNGXaClF1p36wXUcOCqbbkgQ9naSelTtLMQcOz1wlxQ--
Message-ID: <45A6020F.6030604@yahoo.com.au>
Date: Thu, 11 Jan 2007 20:23:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: Christoph Lameter <clameter@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
References: <20070110223731.GC44411608@melbourne.sgi.com> <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com> <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au> <20070111003158.GT33919298@melbourne.sgi.com> <45A58DFA.8050304@yahoo.com.au> <20070111063555.GB33919298@melbourne.sgi.com>
In-Reply-To: <20070111063555.GB33919298@melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. BTW. You didn't cc this to the list, so I won't either in case
you want it kept private.

David Chinner wrote:
> On Thu, Jan 11, 2007 at 12:08:10PM +1100, Nick Piggin wrote:
> 
>>Ahh, sorry to be unclear, I meant:
>>
>>  cat /proc/vmstat > pre
>>  run_test
>>  cat /proc/vmstat > post
> 
> 
> 6 files attached - 2.6.18 pre/post, 2.6.20-rc3 dirty_ratio = 10 pre/post
> and 2.6.20-rc3 dirty_ratio=40 pre/post.
> 
> Cheers,
> 
> Dave.
> 
> 
> ------------------------------------------------------------------------
Send instant messages to your online friends http://au.messenger.yahoo.com 
