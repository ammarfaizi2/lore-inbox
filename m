Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUHEBVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUHEBVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUHEBVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:21:21 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:23886 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267535AbUHEBVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 21:21:19 -0400
Message-ID: <41118B87.3080604@yahoo.com.au>
Date: Thu, 05 Aug 2004 11:21:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <cone.1091614334.471559.9775.502@pc.kolivas.org> <4110BB88.3030400@yahoo.com.au> <20040804114232.GA23285@outpost.ds9a.nl>
In-Reply-To: <20040804114232.GA23285@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

>On Wed, Aug 04, 2004 at 08:33:44PM +1000, Nick Piggin wrote:
>
>
>>>Well duh... disable interactivity and interactivity is bad. What's the 
>>>problem? It's not meant to be used on a desktop in that way.
>>>
>>Well why would you want to disable it then?
>>
>
>When not on a desktop of course - most servers don't care about X
>interactivity but do care a lot about 'nice', and would not want to grant a
>process the CPU (unfairly) longer to satisfy the human need for snappy
>responses.
>
>

Fairness is a pretty basic property though, and should not be dropped 
lightly.
Even on the desktop, unfairness could be explicitly wrong for a small number
of users, while also opening you up to "implicit" corner cases.

As far as interactivity goes maybe it can be disregarded on servers, 
maybe it
can't. What about multi user servers? Does it only apply to X interactivity?
Then how about multi user desktops? Maybe not a big deal.

Fairness should be fundamental though (IMO).

