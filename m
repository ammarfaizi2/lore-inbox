Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWIWSAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWIWSAa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 14:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIWSAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 14:00:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751363AbWIWSAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 14:00:30 -0400
Date: Sat, 23 Sep 2006 11:00:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: David Schwartz <davids@webmaster.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: The GPL: No shelter for the Linux kernel?
In-Reply-To: <Pine.LNX.4.61.0609231004330.9543@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0609231051570.4388@g5.osdl.org>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com>
 <Pine.LNX.4.61.0609231004330.9543@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Sep 2006, Jan Engelhardt wrote:
> 
> Now that you raise it: I think developers can already have done that 
> if they wish - properly name author and conditions who may possibly 
> change the license to what. Not that I have seen such code yet, but you 
> never know.

Side note: in "git", we kind of discussed this. And because the project 
was started when the whole GPL version discussion was already in bloom, 
the git project has a note at top of the COPYING file that says:

 Note that the only valid version of the GPL as far as this project
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

 HOWEVER, in order to allow a migration to GPLv3 if that seems like
 a good idea, I also ask that people involved with the project make
 their preferences known. In particular, if you trust me to make that
 decision, you might note so in your copyright message, ie something
 like

        This file is licensed under the GPL v2, or a later version
        at the discretion of Linus.

  might avoid issues. But we can also just decide to synchronize and
  contact all copyright holders on record if/when the occasion arises.

but note how it's still at the discretion of the actual developers (ie 
when you add a file, you can either not specify any extensions, in which 
case it's "GPLv2 only", or you can specify "GPLv2 or any later", or you 
can specify the "GPLv2 or any later at the discretion of Linus Torvalds".

The silly thing, of course, is that I'm not even the maintainer any more, 
and that Junio has done a kick-ass job of maintaining the thing, and is 
definitely the main author by now. So the whole "discretion of Linus" is a 
bit insane.

[ Although exactly _because_ Junio has been such a great maintainer, I'd 
  bow down to whatever decision he does, so my "discretion" would be to 
  let him decide, if he wanted to. At some point, you have to trust some 
  people, and just let go - if they do more than you do, they damn well 
  have more rights than you do too. "Maintainership has its privileges" ]

Anyway, I suspect the git language was a mistake. We should just have done 
what the kernel did - make the version number be clear and fixed, so that 
people don't even have to worry about exactly what conditions might cause 
a relicensing to happen.

				Linus
