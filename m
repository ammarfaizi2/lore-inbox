Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316661AbSEVS2r>; Wed, 22 May 2002 14:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSEVS1l>; Wed, 22 May 2002 14:27:41 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26044 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316643AbSEVS0Q>; Wed, 22 May 2002 14:26:16 -0400
Date: Wed, 22 May 2002 11:24:57 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: William Lee Irwin III <wli@holomorphy.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, torvalds@transmeta.com,
        akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <366680000.1022091897@flay>
In-Reply-To: <E17AaGD-0002OH-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I wouldn't bother using RedHat's kernel for this at the moment, 
>> Andrea's tree is where the development work for this area has all
>> been happening recently. He's working on integrating O(1) sched
>> right now, which will get rid of the biggest issue I have with -aa
> 
> Still ? Its been in the Red Hat 7.3 tree since we released it. Its also
> in the -ac tree all nicely merged. I guess your definition of happening
> is my definition of "happened" 8)

There are definitely good things in both trees for this problem area at
the moment. If you're interested in fixing this Alan and Andrea, let's start a 
mergefest. I'm sure I can volunteer some IBM resources to help port patches, 
and test the hell out of it .... if you're willing to consider taking things, I'll draw
up a list of what the issues are, what patches are available, and which
trees they reside in (often none ;-( )

If my spies are correct, 7.3AS kernel is still based off the old 2.4.9 VM, with
no rmap at present ... correct? I presume 7.3 is 2.4.18 or so VM with rmap?

M.

