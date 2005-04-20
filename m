Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVDTPKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVDTPKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 11:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVDTPKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 11:10:07 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:53932 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261624AbVDTPKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 11:10:01 -0400
Message-ID: <42666FF5.7010909@nortel.com>
Date: Wed, 20 Apr 2005 09:06:29 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>, Chris Wedgwood <cw@f00f.org>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org> <4265D80F.6030007@lab.ntt.co.jp> <20050420054352.GA7329@taniwha.stupidest.org> <4266062B.9060400@lab.ntt.co.jp> <20050420075031.GA31785@taniwha.stupidest.org> <42660B6B.6040600@lab.ntt.co.jp> <20050420082655.GA2756@taniwha.stupidest.org> <4266168C.7050301@lab.ntt.co.jp> <Pine.LNX.4.61.0504200718570.23123@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0504200718570.23123@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Wed, 20 Apr 2005, Takashi Ikebe wrote:

>>Well, as many said Live patching is very historical & authoritative
>>function on especially carrier, telecom vendor.
>>If linux want to be adopted on mission critical world, this function is
>>esseintial.

> Yes, if you want to use Linux in those scenarios you will
> need to change the telco programs to use shared memory and
> file descriptor passing, instead of live patching.

Unfortunately we're also dealing (in many cases) with pre-existing 
software coming over from other OS's.  The beancounters want to avoid 
rewriting the millions of lines of application code, so they'd rather 
add the missing support to the kernel.

If it doesn't go into mainline, we'll just end up with a bunch of 
different telco-patches being maintained on the side.  I highly doubt 
all the applications will get fixed any time soon.

Chris
