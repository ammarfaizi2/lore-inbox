Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSLHMWX>; Sun, 8 Dec 2002 07:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbSLHMWX>; Sun, 8 Dec 2002 07:22:23 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:25987 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S261448AbSLHMWW>; Sun, 8 Dec 2002 07:22:22 -0500
From: Erik Hensema <usenet@hensema.xs4all.nl>
Subject: Re: /proc/pci deprecation?
Date: Sun, 8 Dec 2002 12:30:00 +0000 (UTC)
Message-ID: <slrnav6eq7.6d2.usenet@dexter.hensema.net>
References: <997222131F7@vcnet.vc.cvut.cz> <20021207131424.GL32065@louise.pinerecords.com> <20021207185252.GC1588@ppc.vc.cvut.cz>
Reply-To: erik@hensema.xs4all.nl
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec (vandrove@vc.cvut.cz) wrote:
> On Sat, Dec 07, 2002 at 02:14:24PM +0100, Tomas Szepe wrote:
>> > > IMO, yes, since those tools provide the summary, and exist almost purely in
>> > > userspace. I forgot to mention in the orginal email that we could also drop
>> > > the PCI names database, right? This would save a considerable amount in the
>> > > kernel image alone..
>> > 
>> > If you want, make it user configurable like it was during 2.2.x. But
>> > I personally prefer descriptive names and system overview I can parse 
>> > without having mounted /usr to get working lspci.
>> 
>> Actually I'm inclined to insist that lspci belong in /sbin.  Really.  :)
> 
> Try it. At least on Debian it is useless without name database, which lives in
> /usr/share/misc/pci.ids...  I can read numbers directly from /proc/bus/pci, if
> I want numbers.

Hmmmm, on SuSE 8.0 too. I consider this a bug. Or at least a misfeature.
Binaries in /bin and /sbin should not need anything from /usr.

-- 
Erik Hensema <erik@hensema.net>
