Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTHQMvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTHQMvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:51:04 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:47581 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S269621AbTHQMvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:51:01 -0400
Message-ID: <3F3F7A79.1060404@softhome.net>
Date: Sun, 17 Aug 2003 14:52:09 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
References: <lg0i.6yo.11@gated-at.bofh.it> <lgjJ.6Oo.5@gated-at.bofh.it> <lilr.p2.7@gated-at.bofh.it> <lj7O.14a.1@gated-at.bofh.it>
In-Reply-To: <lj7O.14a.1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2003-08-17 at 00:06, David D. Hagood wrote:
> 
>>>Your logfiles just got DoS'ed....
>>
>>
>>Why not then just log uncaught exceptions?
> 
> 
> man acct
> 

     Sorry, probably I'm missing smth. man acct(2) says:

     "DESCRIPTION
     "When  called  with the name of an existing file as argument, 
ccounting is turned on, records for each  terminating  process  are 
appended  to filename as it terminates.  An argument of NULL causes 
accounting to be turned off".

     I do not see how it relates to abends.
     It logs _everything_, what is not that useful. Having some kind of 
filter what to log - whould be just great. Or alternatively ability to 
pass file descriptor - not file name.

     And this mysterious NOTES:

     "No accounting is produced for programs running when a crash 
occurs.  In particular, nonterminating processes are never accounted for".

     Sounds like acct() does reverse? No crashes are logged.
     Or it is about Linux crash?

