Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVB1XJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVB1XJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVB1XJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:09:18 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:60895 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261808AbVB1XJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:09:13 -0500
Message-ID: <4223A5C3.6010000@tmr.com>
Date: Mon, 28 Feb 2005 18:14:11 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: James Bruce <bruce@andrew.cmu.edu>
CC: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <20050228134410.GA7499@bytesex><20050228134410.GA7499@bytesex> <42232DFC.6090000@andrew.cmu.edu>
In-Reply-To: <42232DFC.6090000@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:
> Well, are there any theories as to why it would work flawlessly, then 
> after a hard lockup (due to what I think is a buggy V4L2 application), 
> that the cards no longer work?  That was with 2.6.10, but after they 
> started failing I tried 2.6.11-rc5 and it doesn't work either.  By the 
> way, I sent the wrong output; what I sent was from 2.6.11-rc5.  The 
> 2.6.10 output is below, and looks similar except for generating a 
> different error message.

Is there any chance that the lockup was related to an external event, 
like a spike on the line to the video? Or any other outside event? It 
seems like a very odd failure mode, but since I'm about to drop in a 
bttv card and digitize about a hundred old tapes, I'd like to know.

Did you try the "card=" suggestion?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
