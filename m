Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWFNATw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWFNATw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWFNATw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:19:52 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:64721 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932371AbWFNATv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:19:51 -0400
Message-ID: <448F561D.5080007@candelatech.com>
Date: Tue, 13 Jun 2006 17:19:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: "Brian F. G. Bidulock" <bidulock@openss7.org>,
       Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse> <448F4D6F.9070601@candelatech.com> <200606131906.16683.chase.venters@clientec.com>
In-Reply-To: <200606131906.16683.chase.venters@clientec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
> On Tuesday 13 June 2006 18:42, Ben Greear wrote:
> 
>>Chase Venters wrote:
>>
>>>At least some of us feel like stable module APIs should be explicitly
>>>discouraged, because we don't want to offer comfort for code that
>>>refuses to live in the tree (since getting said code into the tree is
>>>often a goal).
>>
>>Some of us write modules for specific features that are not wanted in
>>the mainline kernel, even though they are pure GPL.  Our life is hard
>>enough with out people setting out to deliberately make things more
>>difficult!
> 
> 
> Fair enough, but if you are doing out of tree, pure GPL modules, 
> EXPORT_SYMBOL_GPL() isn't a bad thing, is it?
> 
> Don't mistake me for actually having a big opinion specifically about this 
> socket API's usage of EXPORT_SYMBOL()... just raising some points that I 
> think apply to these decisions in general. I don't really see a compelling 
> reason for EXPORT_SYMBOL() over EXPORT_SYMBOL_GPL() on the socket APIs 
> though... I'm trying to imagine what kind of legitimate non-GPL modules might 
> use them.

I got to the flame war late and only saw your comment that stable API should
be discouraged.  That kind of thinking pisses me off because it assumes all
modules out of the tree are that way because the authors want them out of the
tree.  I also understand that sometimes API needs to change, but please don't
encourage change just to punish other authors, be they proprietary or otherwise.

As for what type of EXPORT macro to use I surely don't have anything to
say that hasn't been said multiple times before.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

