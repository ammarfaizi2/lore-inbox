Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292811AbSB0SSr>; Wed, 27 Feb 2002 13:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292863AbSB0SSS>; Wed, 27 Feb 2002 13:18:18 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:24770 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292865AbSB0SRw>; Wed, 27 Feb 2002 13:17:52 -0500
Message-ID: <3C7D22B8.9070304@us.ibm.com>
Date: Wed, 27 Feb 2002 10:17:28 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020222
X-Accept-Language: en-us
MIME-Version: 1.0
To: doug@lathi.net
CC: linux-kernel@vger.kernel.org
Subject: Re: cs46xx on ThinkPad A22m and poor quality output
In-Reply-To: <87vgcjvs1p.fsf@localhost.localdomain> <87pu2r1x7s.fsf@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Alcorn wrote:
> I hate to follow up to my own post; however, I managed to get the card
> working well with the alsa cs46xx driver.  This would imply to me that
> it's a bug in the linux kernel driver for the cs46xx (is this referred
> to as the oss driver?).
 >
> BTW, someone suggested I simply turn the volume down using the
> hardware buttons on the keyboard.  The poor sound quality is really
> irrespective of the speaker volume.  Maybe this wasn't clear when I
> talked about the "higher-levels of output".  I'm not sure about the
> right vocabulary.  I guess it's the power output on the individual
> frequency bands.

You aren't crazy.  Lots of us with T2[012]'s have this problem.  It does 
indeed appear to be a problem with the OSS version of the driver. 
Someone had a theory that the APM code stays in an interrupt too long 
and causes the card to get into an unanticipated state, causing the poor 
sound quality.

The weird part is that some of us see the problem often, while some 
never see it at all.  I haven't had it happen in months, so I suspect 
that later versions of the kernel are better equipped to handle it.  At 
least the ALSA one seems to work better.

-- 
Dave Hansen
haveblue@us.ibm.com

