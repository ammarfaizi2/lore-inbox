Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbTCGAys>; Thu, 6 Mar 2003 19:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbTCGAys>; Thu, 6 Mar 2003 19:54:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41997 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261311AbTCGAym>; Thu, 6 Mar 2003 19:54:42 -0500
Message-ID: <3E67F03F.2070902@zytor.com>
Date: Thu, 06 Mar 2003 17:05:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <20030307001655.GB13766@kroah.com> <Pine.LNX.4.44.0303070156430.32518-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0303070156430.32518-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 6 Mar 2003, Greg KH wrote:
> 
>>Here's a series of changesets that add klibc support to the 2.5.64
>>kernel.  The only change since the last time I sent this is an addition
>>of a LICENSE file to the klibc directory, and a merge with your latest
>>bk tree.
> 
> Ok, nobody wants to mention it, so I'll have to do it.
> Above license is the BSD license. What were the exact reasons to choose 
> this one? 
> 

Actually, it's the MIT license, which differs from the (new) BSD license
only in the no-endorsement clause, which seemed superfluous.

It was chosen because klibc is a non-dynamic library, and it would
otherwise be extremely awkward to link proprietary code against it if
someone would like to do so.  Furthermore, I'm the author of most of the
code in there, and if someone really wants to rip it off it's not a huge
deal to me.

	-hpa




