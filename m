Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWC1UWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWC1UWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWC1UWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:22:14 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:38027 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932141AbWC1UWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:22:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nyy2zifg0tzxCC4Zex1BEeFGrJuM35+tdd8Y7DgYV9ZDqgUz+zDlKjAFcXQ46Kf5uytOA11sE+nz7XtDuzGCOAm5i649qEE/+0MFAF+V08fBMc7QJE1aDQ3oPovRESOKCc7DTFci/kN4zvYyFkhIfTtblkJ/tni1dqbZ0CfszNA=  ;
Message-ID: <44294BE4.2030409@yahoo.com.au>
Date: Wed, 29 Mar 2006 00:44:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at> <4428FB29.8020402@yahoo.com.au> <20060328142639.GE14576@MAIL.13thfloor.at>
In-Reply-To: <20060328142639.GE14576@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> On Tue, Mar 28, 2006 at 07:00:25PM +1000, Nick Piggin wrote:

>>And if it is intrusive to the core kernel, then as always we have to
>>try to evaluate the question "is it worth it"? How many people want it
>>and what alternatives do they have (eg. maintaining seperate patches,
>>using another approach), what are the costs, complexities, to other
>>users and developers etc.
> 
> 
> my words, but let me ask, what do you consider 'intrusive'?
> 

I don't think I could give a complete answer...
I guess it could be stated as the increase in the complexity of
the rest of the code for someone who doesn't know anything about
the virtualization implementation.

Completely non intrusive is something like 2 extra function calls
to/from generic code, changes to data structures are transparent
(or have simple wrappers), and there is no shared locking or data
with the rest of the kernel. And it goes up from there.

Anyway I'm far from qualified... I just hope that with all the
work you guys are putting in that you'll be able to justify it ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
