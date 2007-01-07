Return-Path: <linux-kernel-owner+w=401wt.eu-S964971AbXAGTWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbXAGTWK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbXAGTWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:22:09 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43384 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964956AbXAGTWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:22:06 -0500
Date: Sun, 7 Jan 2007 20:07:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>,
       Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
In-Reply-To: <20070107104943.ee2c5e6f.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.61.0701072004290.4365@yvahk01.tjqt.qr>
References: <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com>
 <20070107090336.GA7741@1wt.eu> <Pine.LNX.4.61.0701071141580.4365@yvahk01.tjqt.qr>
 <20070107104943.ee2c5e6f.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 7 2007 10:49, Randy Dunlap wrote:
>On Sun, 7 Jan 2007 11:50:57 +0100 (MET) Jan Engelhardt wrote:
>> On Jan 7 2007 10:03, Willy Tarreau wrote:
>> >On Sun, Jan 07, 2007 at 12:58:38AM -0800, H. Peter Anvin wrote:
>> >> >[..]
>> >> >entries in directories with millions of files on disk. I'm not
>> >> >certain it would be that easy to try other filesystems on
>> >> >kernel.org though :-/
>> >> 
>> >> Changing filesystems would mean about a week of downtime for a server. 
>> >> It's painful, but it's doable; however, if we get a traffic spike during 
>> >> that time it'll hurt like hell.
>> 
>> Then make sure noone releases a kernel ;-)
>
>maybe the week of LCA ?

I don't know that acronym, but if you ask me when it should happen:
_Before_ the next big thing is released, e.g. before 2.6.20-final.
Reason: You never know how long they're chewing [downloading] on 2.6.20.
Excluding other projects on kernel.org from my hypothesis, I'd suppose the
lowest bandwidth usage the longer no new files have been released. (Because
everyone has them then more or less.)


	-`J'
-- 
