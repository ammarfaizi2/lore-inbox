Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUHZKOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUHZKOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267945AbUHZKAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:00:53 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:22925 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268032AbUHZJs7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:48:59 -0400
Date: Thu, 26 Aug 2004 11:51:38 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <782176906.20040826115138@tnonline.net>
To: Matt Mackall <mpm@selenic.com>
CC: Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       <torvalds@osdl.org>, <reiser@namesys.com>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826044425.GL5414@waste.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net>
 <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
 <1453698131.20040826011935@tnonline.net>
 <20040825163225.4441cfdd.akpm@osdl.org>
 <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net>
 <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Wed, Aug 25, 2004 at 05:42:21PM -0700, Nicholas Miell wrote:
>> On Wed, 2004-08-25 at 16:46, Wichert Akkerman wrote:
>> > Previously Jeremy Allison wrote:
>> > > Multiple-data-stream files are something we should offer, definately (IMHO).
>> > > I don't care how we do it, but I know it's something we need as application
>> > > developers.
>> > 
>> > Aside from samba, is there any other application that has a use for
>> > them? 
>> > 
>> 
>> Anything that currently stores a file's metadata in another file really
>> wants this right now. Things like image thumbnails, document summaries,
>> digital signatures, etc.

> That is _highly_ debatable. I would much rather have my cp and grep
> and cat and tar and such continue to work than have to rewrite every
> tool because we've thrown the file-is-a-stream-of-bytes concept out
> the window. Never mind that I've got thumbnails, document summaries,
> and digital signatures already.

  In  Windows,  the  extra file streams are not lost or removed if you
  use  a  program that doesn't support them. They are only lost if you
  move the file to a file system that doesn't support the streams.

  Even RAR support the NTFS file streams.

> While the number of annoying properties of files with forks is
> practically endless, the biggest has got to be utter lack of
> portability. How do you stick the thing in an attachment or on an ftp
> site? Well you can't because it's NOT A FILE. 

> A file is a stream of bytes.





