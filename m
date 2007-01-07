Return-Path: <linux-kernel-owner+w=401wt.eu-S964970AbXAGTao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbXAGTao (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbXAGTao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:30:44 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:49778 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964970AbXAGTan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:30:43 -0500
Date: Sun, 7 Jan 2007 11:28:34 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>,
       Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
Message-Id: <20070107112834.a8746a98.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.61.0701072004290.4365@yvahk01.tjqt.qr>
References: <458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<1166304080.13548.8.camel@nigel.suspend2.net>
	<459152B1.9040106@zytor.com>
	<1168140954.2153.1.camel@nigel.suspend2.net>
	<45A08269.4050504@zytor.com>
	<45A083F2.5000000@zytor.com>
	<Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
	<20070107085526.GR24090@1wt.eu>
	<45A0B63E.2020803@zytor.com>
	<20070107090336.GA7741@1wt.eu>
	<Pine.LNX.4.61.0701071141580.4365@yvahk01.tjqt.qr>
	<20070107104943.ee2c5e6f.randy.dunlap@oracle.com>
	<Pine.LNX.4.61.0701072004290.4365@yvahk01.tjqt.qr>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 20:07:43 +0100 (MET) Jan Engelhardt wrote:

> 
> On Jan 7 2007 10:49, Randy Dunlap wrote:
> >On Sun, 7 Jan 2007 11:50:57 +0100 (MET) Jan Engelhardt wrote:
> >> On Jan 7 2007 10:03, Willy Tarreau wrote:
> >> >On Sun, Jan 07, 2007 at 12:58:38AM -0800, H. Peter Anvin wrote:
> >> >> >[..]
> >> >> >entries in directories with millions of files on disk. I'm not
> >> >> >certain it would be that easy to try other filesystems on
> >> >> >kernel.org though :-/
> >> >> 
> >> >> Changing filesystems would mean about a week of downtime for a server. 
> >> >> It's painful, but it's doable; however, if we get a traffic spike during 
> >> >> that time it'll hurt like hell.
> >> 
> >> Then make sure noone releases a kernel ;-)
> >
> >maybe the week of LCA ?

Sorry, it means Linux.conf.au (Australia):
  http://lca2007.linux.org.au/
Jan. 15-20, 2007

> I don't know that acronym, but if you ask me when it should happen:
> _Before_ the next big thing is released, e.g. before 2.6.20-final.
> Reason: You never know how long they're chewing [downloading] on 2.6.20.
> Excluding other projects on kernel.org from my hypothesis, I'd suppose the
> lowest bandwidth usage the longer no new files have been released. (Because
> everyone has them then more or less.)

ISTM that Linus is trying to make 2.6.20-final before LCA.  We'll see.

---
~Randy
