Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbTCLRTD>; Wed, 12 Mar 2003 12:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261794AbTCLRTD>; Wed, 12 Mar 2003 12:19:03 -0500
Received: from terminus.zytor.com ([63.209.29.3]:35490 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S261789AbTCLRTC>; Wed, 12 Mar 2003 12:19:02 -0500
Message-ID: <3E6F6E84.1010601@zytor.com>
Date: Wed, 12 Mar 2003 09:29:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dana Lacoste <dana.lacoste@peregrine.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
References: <20030312034330.GA9324@work.bitmover.com>	<20030312041621.GE563@phunnypharm.org> <20030312085517.GK811@suse.de>	<20030312032614.G12806@schatzie.adilger.int> 	<b4nmau$3d0$1@cesium.transmeta.com> <1047486659.16704.161.camel@dlacoste.ottawa.loran.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana Lacoste wrote:
> On Wed, 2003-03-12 at 11:13, H. Peter Anvin wrote:
> 
>>"Can we get our data out of BK into some kind of open format?"
> 
> 
>>It's an important question.  If the answer is "yes, but only the stuff
>>that can be mapped onto CVS" then that's a significant data loss, and
>>if BitMover changes the data format without documentation, then there
>>is no longer a way to get all the data out.
> 
> 
> This sounds like the old GPL argument.
> 
> The GPL'd redistributor has to supply the source, they don't have to
> supply it in the format that's best for you, being an 80mm tape drive
> cuz you're stuck in the punch card age.
> 
> Seriously, if CVS loses all that data, is that BK's fault?  BK's so
> powerful because it has more information than anyone else, but it's
> not their fault (and it's not proprietary data) that no-one else can
> deal with the data when it's exported, now is it????
> 
> It's not a significant data loss when you try to view a 24bpp image
> on an 8bpp display, so it's not a significant data loss that CVS can't
> handle the BK.  If it could, Linus would've switched to CVS instead....
> 

You're missing the point completely.

Of course it's not BK's fault that CVS can't represent the data. 
However, one of the (valid!) selling points of BK was "we won't hold 
your data hostage."  That requires that you can export both the data and 
the metadata into some kind of open format.  Since CVS clearly can't be 
that open format (CVS being insufficiently powerful), the additional 
metadata needs to be available in some kind of auxilliary form.  It's 
then, of course, not BK's fault that CVS can't possibly make use of that 
auxilliary metadata.

	-hpa


