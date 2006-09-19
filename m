Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWISSsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWISSsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWISSsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:48:52 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:7284 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750893AbWISSsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:48:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OqqOQ2pt5K31O7Vuv+P86uYmds+fCpymNQsxGoMwfITjZDl1GE5fA5Q24e54SE3baU/D5o4H7zVe1rD15tgWRKJzq4sbf5WjbBzDLzh9F7A69RdiY1EhDm+AVhNgdYKxDeDsNNg3GeoSd9RkI2Pr9cozvfXR+Lfe7RC2x8mNoaE=  ;
Message-ID: <45103B8D.1040006@yahoo.com.au>
Date: Wed, 20 Sep 2006 04:48:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Alan Stern <stern@rowland.harvard.edu>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
References: <Pine.LNX.4.44L0.0609191332470.4345-100000@iolanthe.rowland.org> <45102E21.2060301@yahoo.com.au> <20060919181919.GG1310@us.ibm.com>
In-Reply-To: <20060919181919.GG1310@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> On Wed, Sep 20, 2006 at 03:51:29AM +1000, Nick Piggin wrote:

>>If store forwarding is able to occur outside cache coherency protocol,
>>then I don't see why not. I would also be interested to know if this
>>is the case on real systems.
> 
> 
> We are discussing multiple writes to the same variable, correct?
> 
> Just checking...

Correct.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
