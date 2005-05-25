Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVEYDYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVEYDYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 23:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVEYDYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 23:24:52 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:58970 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262257AbVEYDYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 23:24:30 -0400
Message-ID: <4293EFE8.1080106@yahoo.com.au>
Date: Wed, 25 May 2005 13:24:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Andrew Morton <akpm@osdl.org>, Sven Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, mingo@elte.hu, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu>	 <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu>	 <4292F074.7010104@yahoo.com.au>	 <1116957953.31174.37.camel@dhcp153.mvista.com>	 <20050524224157.GA17781@nietzsche.lynx.com>	 <1116978244.19926.41.camel@dhcp153.mvista.com>	 <20050525001019.GA18048@nietzsche.lynx.com>	 <1116981913.19926.58.camel@dhcp153.mvista.com>	 <20050525005942.GA24893@nietzsche.lynx.com>	 <1116982977.19926.63.camel@dhcp153.mvista.com>	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>	 <20050524192029.2ef75b89.akpm@osdl.org> <1116987976.2912.110.camel@mindpipe>
In-Reply-To: <1116987976.2912.110.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Tue, 2005-05-24 at 19:20 -0700, Andrew Morton wrote:
>
>>Sven Dietrich <sdietrich@mvista.com> wrote:
>>
>>>I think people would find their system responsiveness / tunability
>>> goes up tremendously, if you drop just a few unimportant IRQs into
>>> threads.
>>>
>>People cannot detect the difference between 1000usec and 50usec latencies,
>>so they aren't going to notice any changes in responsiveness at all.
>>
>
>The IDE IRQ handler can in fact run for several ms, which people sure
>can detect.
>
>

Are you serious? Even at 10ms, the monitor refresh rate would have to be
over 100Hz for anyone to "notice" anything, right?... What sort of numbers
are you talking when you say several?

Send instant messages to your online friends http://au.messenger.yahoo.com 
