Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVB1Xqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVB1Xqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVB1Xqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:46:48 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:63107 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261822AbVB1Xqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:46:46 -0500
Message-ID: <4223AD5F.1090500@yahoo.com.au>
Date: Tue, 01 Mar 2005 10:46:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Schmid <webmaster@rapidforum.com>
CC: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Slowdown on high-load machines with 3000 sockets
References: <4221FB13.6090908@rapidforum.com> <Pine.LNX.4.61.0502271216050.19979@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0502271606220.19979@chimarrao.boston.redhat.com> <422239A8.1090503@rapidforum.com> <Pine.LNX.4.61.0502271830380.19979@chimarrao.boston.redhat.com> <42225B34.7020104@rapidforum.com> <Pine.LNX.4.61.0502271905270.19979@chimarrao.boston.redhat.com> <42226607.6020803@rapidforum.com> <4222A887.80301@yahoo.com.au> <4223696C.8060407@rapidforum.com>
In-Reply-To: <4223696C.8060407@rapidforum.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid wrote:
> This issue has been tracked down more. This bug does NOT appear if I 
> disable preemtive kernel.
> Maybe this helps.
> 

Yes, it may help - can you boot with profile=schedule and get
the results for say, a 30 second period while the application
is experiencing problems?

So:

start application
wait till it hits slowdown
readprofile -r ; sleep 30 ; readprofile > schedprof.out

and send schedprof.out, please?

Thanks,
Nick

