Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbWGaVWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbWGaVWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWGaVWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:22:55 -0400
Received: from abdw250.neoplus.adsl.tpnet.pl ([83.7.8.250]:57774 "EHLO
	pcserwis") by vger.kernel.org with ESMTP id S932529AbWGaVWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:22:54 -0400
Date: Mon, 31 Jul 2006 23:21:42 +0200
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
From: =?iso-8859-2?B?o3VrYXN6IE1pZXJ6d2E=?= <prymitive@pcserwis.hopto.org>
Organization: PC Serwis
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
MIME-Version: 1.0
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl> <20060731173239.GO31121@lug-owl.de>
Content-Transfer-Encoding: 8bit
Message-ID: <op.tdkoagt5d4os1z@localhost>
In-Reply-To: <20060731173239.GO31121@lug-owl.de>
User-Agent: Opera Mail/9.00 (Linux)
X-PCSerwis-MailScanner-Information: Please contact the ISP for more information
X-PCSerwis-MailScanner: Found to be clean
X-PCSerwis-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-15.205, required 6, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 1.59, BAYES_00 -15.00)
X-MailScanner-From: prymitive@pcserwis.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Mon, 31 Jul 2006 19:32:39 +0200, Jan-Benedict Glaw  
<jbglaw@lug-owl.de> napisa³:

> On Mon, 2006-07-31 18:44:33 +0200, Rudy Zijlstra <rudy@edsons.demon.nl>  
> wrote:
>> On Mon, 31 Jul 2006, Jan-Benedict Glaw wrote:
>> > On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich
>> > <reiser4@blinkenlights.ch> wrote:
>> > > A colleague of mine happened to create a ~300gb filesystem and  
>> started
>> > > to migrate Mailboxes (Maildir-style format = many small files  
>> (1-3kb))
>> > > to the new LUN. At about 70% the filesystem ran out of inodes; Not a
>> >
>> > So preparation work wasn't done.
>>
>> Of course you are right. Preparation work was not fully done. And using
>> ext1 would also have been possible. I suspect you are still using ext1,
>> cause with proper preparation it is perfectly usable.
>
> Oh, and before people start laughing at me, here are some personal or
> friend's experiences with different filesystems:
>
>   * reiser3: A HDD containing a reiser3 filesystem was tried to be
>     booted on a machine that fucked up DMA writes. Fortunately, it
>     crashed really soon (right after going for read-write.)  After
>     rebooting the HDD on a sane PeeCee, it refused to boot. Starting
>     off some rescue system showed an _empty_ root filesystem.
>
>   * A friend's XFS data partition (portable USB/FireWire HDD) once
>     crashed due to being hot-unplugged off the USB.  The in-kernel XFS
>     driver refused to mount that thing again, and the tools also
>     refused to fix any errors. (Don't ask, no details at my hands...)
>
>   * JFS just always worked for me. Though I've never ever had a broken
>     HDD where it (or it's tools) could have shown how well-done they
>     were, so from a crash-recovery point of view, it's untested.
>
>   * Being a regular ext3 user, I had lots of broken HDDs containing
>     ext3 filesystems. For every single case, it has been easy fixing
>     the filesystem after cloning. Just _once_, fsck wasn't able to fix
>     something, so I did it manually with some disk editor. This worked
>     well because the on-disk data structures are actually as simple as
>     they are.

Is this some kind of "who lost more files on what fs" competition? What's  
the prize?
Topic subject sugests that it should cover something else. Please, let's  
get back on track.
First of all, it's about reiser4 so can't we forget about other  
filesystem's unless it's got something to do with reiser4 merge?
