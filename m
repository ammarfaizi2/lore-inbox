Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTDLQlN (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTDLQlN (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 12:41:13 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:13718 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263336AbTDLQlM (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 12:41:12 -0400
Date: Sat, 12 Apr 2003 12:47:29 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Completely new idea to virtual memory
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304121250_MC3-1-3426-17FE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:


>>   o if swsusp does not need to write already-backed pages it could
>>     reduce suspend time
>
> Hmmm. Not sure if it's worth the time taken to code & run figuring out
> if it's already backed, though :>. Would we ever be talking about a
> significant proportion of pages?


  Depends on how aggressively you write them out, I guess.

  Is there even a way to write pages to swap without unmapping them?


--
 "Let's fight till six, and then have dinner," said Tweedledum.
  --Lewis Carroll, _Through the Looking Glass_
