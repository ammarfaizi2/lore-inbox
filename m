Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281272AbRKEScl>; Mon, 5 Nov 2001 13:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281275AbRKEScb>; Mon, 5 Nov 2001 13:32:31 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:17546 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S281272AbRKEScO>;
	Mon, 5 Nov 2001 13:32:14 -0500
Message-ID: <3BE6DA52.6040100@candelatech.com>
Date: Mon, 05 Nov 2001 11:28:34 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: dalecki@evision.ag
CC: Stephen Satchell <satch@concentric.net>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <200111042213.fA4MDoI229389@saturn.cs.uml.edu> <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42> <3BE6DCCD.8A7CE033@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Dalecki wrote:

> Stephen Satchell wrote:
> 
>>At 12:23 PM 11/5/01 +0100, Martin Dalecki wrote:
>>
>>>Every BASTARD out there telling the world, that parsing ASCII formatted
>>>files
>>>is easy should be punished to providing a BNF definition of it's syntax.
>>>Otherwise I won't trust him. Having a struct {} with a version field,
>>>indicating
>>>possible semantical changes wil always be easier faster more immune
>>>to errors to use in user level programs.
>>>
>>I would love for the people who write the code that generates the /proc
>>info to be required to document the layout of the information.  The best
>>place for that documentation is the source, and in English or other
>>accepted human language, in a comment block.  Not in "header lines" or
>>other such nonsense.  I don't need no stinkin' BNF, just a reasonable


I would rather have a header block, as well as docs in the source.
If the header cannot easily explain it, then the header can have a URL
or other link to the full explanation.  I don't expect to be able to parse
every /proc interface with a single tool, but I would like to be able to
easily parse individual ones with perl, sscanf, etc...

Ben



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


