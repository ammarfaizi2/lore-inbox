Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUH0PPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUH0PPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUH0POQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:14:16 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:50898 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S266133AbUH0PNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:13:15 -0400
Date: Fri, 27 Aug 2004 17:15:20 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1888171711.20040827171520@tnonline.net>
To: Rik van Riel <riel@redhat.com>
CC: Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       <jamie@shareable.org>, <christophe@saout.de>,
       <vda@port.imtp.ilyichevsk.odessa.ua>, <christer@weinigel.se>,
       <akpm@osdl.org>, <wichert@wiggy.net>, <jra@samba.org>, <hch@lst.de>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <flx@namesys.com>, <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
References: <412EEB75.1030401@namesys.com>
 <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 27 Aug 2004, Hans Reiser wrote:

>> Why are you guys even considering going to any pain at all to distort
>> semantics for the sake of backup?  tar is easy, we'll fix it and send in
>> a patch. 

> It's not as easy as you make it out, and not just because
> there are a few dozen backup programs that need fixing.

> The problem is more fundamental than that.  Some of the
> file streams proposed need to be backed up, while others
> are alternative presentations of the file, which should
> not be backed up.

  No, not really. This is a user decision and should be options in the
  backup  software.  I don't think it is up to the kernel, filesystem,
  or  the  OS  in  general to decide what information the user want to
  retain or not.

> Currently I see no way to distinguish between the stuff
> that should be backed up and the stuff that shouldn't.

> That problem needs to be resolved before we can even start
> thinking about fixing archivers...

  The  archivers  should,  as  I  said,  allow  the user to choose. It
  shouldn't be automatic. Default, should IMO be to store everything.

  ~S


