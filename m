Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275007AbTHQD1L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 23:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275008AbTHQD1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 23:27:11 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:2690
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S275007AbTHQD1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 23:27:10 -0400
Message-ID: <3F3EF60D.6050708@tupshin.com>
Date: Sat, 16 Aug 2003 20:27:09 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: browser oddities
References: <200308162257.51086.gene.heskett@verizon.net>
In-Reply-To: <200308162257.51086.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>Greetings;
>
>I've just come across another bit of 2.6 trivia.
>
>When browsing the web using mozilla-1.5a on a 2.6.0-test3-mm2 boot,  I 
>find that using the back button takes you back to the top of the 
>previous page.
>
>So I rebooted to 2.4.22-rc2, and now the back button takes you back to 
>the point of departure on the previous page.
>
>Thats the best description I can give, and of course I have NDI what 
>might be causeing it, but it is a bit startling.
>
>This should work as expected before a real 2.6.0 is allowed out to 
>play.
>
>  
>
I'm running Mozilla 1.5a on 2.6.0-test3 (almost unpatched). Browser 
correctly goes to the last scrolled position (on most pages) after 
clicking the back button. I have periodically seen the symptom you 
describe, but I don't believe it's kernel related, since I have seen 
that symptom on 2.4. I would run more tests on both kernels, and look 
for additional variables that could be contributing to it. You might 
also try then non-mm2 test3 in the remote chance that it is a kernel 
problem. Also, make sure the problem isn't specific to certain web 
pages(right now, the problem manifests itself on the bugzilla pages, but 
not on a handful of others that i've just checked), and check against 
bugzilla 210992: http://bugzilla.mozilla.org/show_bug.cgi?id=210992

-Tupshin

