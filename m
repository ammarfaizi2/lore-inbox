Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268534AbTBWTcY>; Sun, 23 Feb 2003 14:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268535AbTBWTcY>; Sun, 23 Feb 2003 14:32:24 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:54974 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S268534AbTBWTcX>; Sun, 23 Feb 2003 14:32:23 -0500
Message-ID: <3E592431.3080606@nyc.rr.com>
Date: Sun, 23 Feb 2003 14:42:41 -0500
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5 weirdness
References: <20030221221814.GA1316@triplehelix.org> <20030221152502.A9282@sonic.net>
In-Reply-To: <20030221152502.A9282@sonic.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hinds wrote:
> On Fri, Feb 21, 2003 at 02:18:14PM -0800, Joshua Kwan wrote:
> 
>>I was wondering if any people might know what is going on here. This
>>happens in 2.5.62, using CardBus pcmcia support within my kernel and
>>the latest pcmcia-cs snapshot.
>>
>>Just to clarify, I have only one wifi card - wlan0.
> 
> 
> It appears that someone broke the code for keeping track of sockets,
> since the PCMCIA drivers are telling cardmgr that the same card is
> inserted twice.
> 
> -- Dave

The problem is a little stranger than that.  On my system, cardmgr only 
"believes" a card is inserted twice if a card is in the pccard slot when 
  cardmgr is intially run.  Otherwise, cardmgr and the drivers appear to 
function correctly.  Josh, can you try this?

I posted a message about this earlier, but I didn't receive a response 
so I still don't understand what's going on.

Subject:  PCMCIA: cardmgr setting up two interfaces for one card?

If you need any more information, please let me know.

(o- j o h n  e  w e b e r
//\  weber@nyc.rr.com
v_/_  aim/yahoo/msn: worldwidwebers

