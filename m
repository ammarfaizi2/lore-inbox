Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTAXWnr>; Fri, 24 Jan 2003 17:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbTAXWnq>; Fri, 24 Jan 2003 17:43:46 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:48628 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264644AbTAXWnq>;
	Fri, 24 Jan 2003 17:43:46 -0500
Message-ID: <3E31C3FA.1060302@acm.org>
Date: Fri, 24 Jan 2003 16:53:46 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: Dan Kegel <dank@kegel.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
References: <Pine.LNX.4.44.0301232144470.8203-100000@coffee.psychology.mcmaster.ca> <3E30F79D.6050709@kegel.com> <20030124082610.GA12781@mark.mielke.cc>
In-Reply-To: <20030124082610.GA12781@mark.mielke.cc>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:

>>And, for what it's worth, programmer productivity is sometimes
>>more important than all the above.  I happen to work
>>at a place where performance is worth a lot of extra effort,
>>but other shops prefer to throw hardware at the problem and
>>not worry about that last 10%.
>>    
>>
>
>Definately an argument for the one thread per connection model. :-)
>
I would disagree.  One thread per connection is easier to conceptually 
understand.  In my experience, an event-driven model (which is what you 
end up with if you use one or a few threads) is actually easier to 
correctly implement and it tends to make your code more modular and 
portable.

-Corey

