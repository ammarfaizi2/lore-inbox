Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318250AbSHMQTc>; Tue, 13 Aug 2002 12:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSHMQTc>; Tue, 13 Aug 2002 12:19:32 -0400
Received: from www.wotug.org ([194.106.52.201]:48945 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S318250AbSHMQT1> convert rfc822-to-8bit; Tue, 13 Aug 2002 12:19:27 -0400
Date: Tue, 13 Aug 2002 17:21:14 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Christoph Hellwig <hch@infradead.org>
cc: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2 compile error
In-Reply-To: <20020813123255.A5393@infradead.org>
Message-ID: <Pine.LNX.4.44.0208131714360.19585-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Christoph Hellwig wrote:

>On Tue, Aug 13, 2002 at 01:01:38PM +0200, Stephane Wirtel wrote:
>Yes, it is.   And I'm pissed that it neither was depend on the devfs config option
>nor had a devfsßrelated named for a long time.  Richard just bloats the whole kernel
>woth devfs crap all over the place.

I would like to defend devfs a bit, although I know nothing of this particular 
case.

I have (for ever) HATED the tendency of Unix systems to have one huge /dev
directory with, often, thousands of completely useless devnodes in it, many of
then with names that are obscure to say the least, and no idea how to find the
right one.

For example, recently I wanted to find the combined mouse device on an RH3
system that I haven't got around to switching to devfs; after a lot of
searching, including in the kernel sources, I gave up. On defvs it's obvious:  
you have /dev/mouse/, and under that "mice", which, being the plural of
"mouse", is pretty clear, IMO.

At least devfs does address this, and IMO quite well. I don't at the moment
understand the problems people have with it (and if possible I would
appreciate a _sensible- discussion), but if anyone wants to return to the 'bad
old days' I'm very much against it.

Rant over,

Regards,

Ruth


-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

